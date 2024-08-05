import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:telekom2/group_chat/Controller/ImagePicker.dart';
import 'package:telekom2/group_chat/controller/ChatController.dart';

import 'package:telekom2/group_chat/model/usermodel.dart';

import '../../../Config/Images.dart';
// import '../../../Controller/ImagePicker.dart';
import '../../../Widget/ImagePickerBottomSeet.dart';




class TypeMessage extends StatelessWidget {
  final UserModelnew userModel;
  const TypeMessage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    TextEditingController messageController = TextEditingController();
    RxString message = "".obs;
    // ImagePickerController imagePickerController =
    //     Get.put(ImagePickerController());
    ImagePickerController imagePickerController=Get.put(ImagePickerController());
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
            child: Image.asset(
              AssetsImage.chatEmoji,
              width: 25,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: (value) {
                message.value = value;
                print("typing...");
                if (value.isNotEmpty) {
                  print("typing...");
                } else {
                  print("not typing");
                }
              },
              onEditingComplete: () {
                print("onEditingComplete");
              },
              controller: messageController,
              decoration: const InputDecoration(
                  filled: false, hintText: "Type message ..."),
            ),
          ),
          SizedBox(width: 10),
          Obx(
            () => chatController.selectedImagePath.value == ""
                ? InkWell(
                    onTap: () {
                      ImagePickerBottomSheet(
                          context,
                          chatController.selectedImagePath,
                          imagePickerController );
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        AssetsImage.chatGallarySvg,
                        width: 25,
                      ),
                    ),
                  )
                : SizedBox(),
          ),
          SizedBox(width: 10),
          Obx(
            () => message.value != "" ||
                    chatController.selectedImagePath.value != ""
                ? InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      if (messageController.text.isNotEmpty ||
                          chatController.selectedImagePath.value.isNotEmpty) {
                        chatController.sendMessage(
                            userModel.id!, messageController.text, userModel);
                        messageController.clear();
                        message.value = "";
                      }
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      child: chatController.isLoading.value
                          ? CircularProgressIndicator()
                          : Image.asset(
                              AssetsImage.chatSendSvg,
                              width: 25,
                            ),
                    ),
                  )
                : Container(
                    width: 30,
                    height: 30,
                    child: Image.asset(
                      AssetsImage.chatMicSvg,
                      width: 25,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
