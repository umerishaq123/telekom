import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telekom2/main.dart';
import '../model/message.dart';
import '../model/user.dart';
import 'firebase_storage_service.dart';

class FirebaseFirestoreService {
  static final firestore = FirebaseFirestore.instance;

  static Future<void> createUser({
    required String uid,
    required String image,
    required String username,
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String confirmpassword,
  }) async {
    final user = UserModel(
        uid: uid,
        image: image,
        username: username,
        firstname: firstname,
        lastname: lastname,
        email: email,
        password: password,
        confirmPassword: confirmpassword,
        lastActive: DateTime.now());

    await firestore.collection('users').doc(uid).set(user.toJson());
  }

  static Future<void> addTextMessage({
    required String content,
    required String receiverId,
  }) async {
    final message = Message(
      content: content,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.text,
      senderId: GetMeEmail.senderId,
    );
    await _addMessageToChat(receiverId, message);
  }

  static Future<void> addImageMessage({
    required String receiverId,
    required Uint8List file,
  }) async {
    final image = await FirebaseStorageService.uploadImage(
        file, 'image/chat/${DateTime.now()}');

    final message = Message(
      content: image,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.image,
      senderId: GetMeEmail.senderId,
    );
    await _addMessageToChat(receiverId, message);
  }

  static Future<void> _addMessageToChat(
    String receiverId,
    Message message,
  ) async {
    await firestore
        .collection('users')
        .doc(GetMeEmail.senderId)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .add(message.toJson());

    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(GetMeEmail.senderId)
        .collection('messages')
        .add(message.toJson());
  }

  static Future<void> updateUserData(Map<String, dynamic> data) async {
    await firestore.collection('users').doc(GetMeEmail.senderId).update(data);
  }

  static Future<List<UserModel>> searchUser(String name) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("name", isGreaterThanOrEqualTo: name)
        .get();

    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }
}
