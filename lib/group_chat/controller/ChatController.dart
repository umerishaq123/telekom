import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telekom2/group_chat/controller/ContactController.dart';
import 'package:telekom2/group_chat/controller/ProfileController.dart';
import 'package:telekom2/group_chat/model/AudioCall.dart';
import 'package:telekom2/group_chat/model/chat_model.dart';
import 'package:telekom2/group_chat/model/chat_room_nodel.dart';
import 'package:telekom2/group_chat/model/usermodel.dart';
import 'package:telekom2/screens/chats/widgets/model/user.dart';

import 'package:uuid/uuid.dart';



class ChatController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  var uuid = Uuid();
  RxString selectedImagePath = "".obs;
  @override
  ProfileController profileController = Get.put(ProfileController());
  ContactController contactController = Get.put(ContactController());
  String getRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

  UserModelnew getSender(UserModelnew currentUser, UserModelnew targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUser;
    } else {
      return targetUser;
    }
  }

  UserModelnew getReciver(UserModelnew currentUser, UserModelnew targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return targetUser;
    } else {
      return currentUser;
    }
  }

  Future<void> sendMessage(
      String targetUserId, String message, UserModelnew targetUser) async {
    isLoading.value = true;
    String chatId = uuid.v6();
    String roomId = getRoomId(targetUserId);
    DateTime timestamp = DateTime.now();
    String nowTime = DateFormat('hh:mm a').format(timestamp);

    UserModelnew sender =
        getSender(profileController.currentUser.value, targetUser);
    UserModelnew receiver =
        getReciver(profileController.currentUser.value, targetUser);

    RxString imageUrl = "".obs;
    if (selectedImagePath.value.isNotEmpty) {
      imageUrl.value =
          await profileController.uploadFileToFirebase(selectedImagePath.value);
    }
    var newChat = ChatModel(
      id: chatId,
      message: message,
      imageUrl: imageUrl.value,
      senderId: auth.currentUser!.uid,
      receiverId: targetUserId,
      senderName: profileController.currentUser.value.name,
      timestamp: DateTime.now().toString(),
      readStatus: "unread",
    );

    var roomDetails = ChatRoomModel(
      id: roomId,
      lastMessage: message,
      lastMessageTimestamp: nowTime,
      sender: sender,
      receiver: receiver,
      timestamp: DateTime.now().toString(),
      unReadMessNo: 0,
    );
    try {
      await db
          .collection("chats")
          .doc(roomId)
          .collection("messages")
          .doc(chatId)
          .set(
            newChat.toJson(),
          );
      selectedImagePath.value = "";
      await db.collection("chats").doc(roomId).set(
            roomDetails.toJson(),
          );
      await contactController.saveContact(targetUser );
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Stream<List<ChatModel>> getMessages(String targetUserId) {
    String roomId = getRoomId(targetUserId);
    return db
        .collection("chats")
        .doc(roomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => ChatModel.fromJson(doc.data()),
              )
              .toList(),
        );
  }

  Stream<UserModelnew> getStatus(String uid) {
    return db.collection('users').doc(uid).snapshots().map(
      (event) {
        return UserModelnew.fromJson(event.data()!);
      },
    );
  }

  Stream<List<CallModel>> getCalls() {
    return db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("calls")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => CallModel.fromJson(doc.data()),
              )
              .toList(),
        );
  }

  Stream<int> getUnreadMessageCount(
    String roomId,
  ) {
    return db
        .collection("chats")
        .doc(roomId)
        .collection("messages")
        .where("readStatus", isEqualTo: "unread")
        .where("senderId", isNotEqualTo: profileController.currentUser.value.id)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Future<void> markMessagesAsRead(String roomId) async {
    QuerySnapshot<Map<String, dynamic>> messagesSnapshot = await db
        .collection("chats")
        .doc(roomId)
        .collection("messages")
        .where("readStatus", isEqualTo: "unread")
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> messageDoc
        in messagesSnapshot.docs) {
      String senderId = messageDoc.data()["senderId"];
      if (senderId != profileController.currentUser.value.id) {
        await db
            .collection("chats")
            .doc(roomId)
            .collection("messages")
            .doc(messageDoc.id)
            .update({"readStatus": "read"});
      }
    }
  }
}
