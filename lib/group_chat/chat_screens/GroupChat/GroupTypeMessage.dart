import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:telekom2/group_chat/Widget/ImagePickerBottomSeet.dart';
import 'package:telekom2/group_chat/controller/ImagePicker.dart';
import 'package:telekom2/group_chat/controller/groupController.dart';
import 'package:telekom2/group_chat/model/groupsmodels.dart';


class GroupTypeMessage extends StatelessWidget {
  final GroupModel groupModel;
  const GroupTypeMessage({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    RxString message = "".obs;
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    GroupController groupController = Get.put(GroupController());
    return Container(
      // margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            child: Icon(Icons.chat)
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: (value) {
                message.value = value;
              },
              controller: messageController,
              decoration: const InputDecoration(
                  filled: false, hintText: "Type message ..."),
            ),
          ),
          SizedBox(width: 10),
          Obx(
            () => groupController.selectedImagePath.value == ""
                ? InkWell(
                    onTap: () {
                      ImagePickerBottomSheet(
                          context,
                          groupController.selectedImagePath,
                          imagePickerController);
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      child:Icon(Icons.browse_gallery_outlined)
                    ),
                  )
                : SizedBox(),
          ),
          SizedBox(width: 10),
          Obx(
            () => message.value != "" ||
                    groupController.selectedImagePath.value != ""
                ? InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      groupController.sendGroupMessage(
                        messageController.text,
                        groupModel.id!,
                        "",
                      );
                      messageController.clear();
                      message.value = "";
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      child: groupController.isLoading.value
                          ? CircularProgressIndicator()
                          : Icon(Icons.send_outlined)
                    ),
                  )
                : Container(
                    width: 30,
                    height: 30,
                    child: Icon(Icons.mic_none_sharp)
                  ),
          ),
        ],
      ),
    );
  }
}
