import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telekom2/group_chat/chat_screens/GroupChat/GroupChat.dart';
import 'package:telekom2/group_chat/controller/groupController.dart';

import 'package:telekom2/group_chat/chat_screens/home/widgets/chattile.dart';
import 'package:telekom2/group_chat/model/groupsmodels.dart';


class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return StreamBuilder<List<GroupModel>>(
      stream: groupController.getGroupss(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        List<GroupModel>? groups = snapshot.data;
        return ListView.builder(
          itemCount: groups!.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(GroupChatPage(groupModel: groups[index]));
              },
              child: ChatTile(
                name: groups[index].name!,
                imageUrl: groups[index].profileUrl == ""
                    ? 'assets/women.png'
                    : groups[index].profileUrl!,
                lastChat: "Group Created",
                lastTime: "Just Now",
              ),
            );
          },
        );
      },
    );
  }
}