import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:telekom2/group_chat/Config/Images.dart';
import 'package:telekom2/group_chat/chat_screens/Chat/ChatPage.dart';
import 'package:telekom2/group_chat/chat_screens/home/widgets/chattile.dart';
import 'package:telekom2/group_chat/controller/ChatController.dart';
import 'package:telekom2/group_chat/controller/ContactController.dart';
import 'package:telekom2/group_chat/controller/ProfileController.dart';
import 'package:telekom2/group_chat/model/chat_room_nodel.dart';



class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    ProfileController profileController = Get.put(ProfileController());
    ChatController chatController = Get.put(ChatController());
    return StreamBuilder<List<ChatRoomModel>>(
      stream: contactController.getChatRoom(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        List<ChatRoomModel>? e = snapshot.data;

        return ListView.builder(
          itemCount: e!.length,
          itemBuilder: (context, index) {
            return InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                chatController.markMessagesAsRead(e[index].id!);
                Get.to(
                  ChatPage(
                    userModel: (e[index].receiver!.id ==
                            profileController.currentUser.value.id
                        ? e[index].sender
                        : e[index].receiver)!,
                  ),
                );
              },
              child: ChatTile(
                imageUrl: (e[index].receiver!.id ==
                            profileController.currentUser.value.id
                        ? e[index].sender!.profileImage
                        : e[index].receiver!.profileImage) ??
                    AssetsImage.defaultProfileUrl,
                name: (e[index].receiver!.id ==
                        profileController.currentUser.value.id
                    ? e[index].sender!.name
                    : e[index].receiver!.name)!,
                lastChat: e[index].lastMessage ?? "Last Message",
                lastTime: e[index].lastMessageTimestamp ?? "Last Time",
              ),
            );
          },
        );
      },
    );
  }
}