import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telekom2/group_chat/controller/ChatController.dart';
import 'package:telekom2/group_chat/controller/ProfileController.dart';




class CallHistory extends StatelessWidget {
  const CallHistory({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    ProfileController profileController = Get.put(ProfileController());
    return StreamBuilder(
        stream: chatController.getCalls(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                DateTime timestamp =
                    DateTime.parse(snapshot.data![index].timestamp!);
                String formattedTime = DateFormat('hh:mm a').format(timestamp);
                return ListTile(
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data![index].callerUid ==
                                profileController.currentUser.value.id
                            ? snapshot.data![index].receiverPic == null
                                ? ""
                                : snapshot.data![index].receiverPic!
                            : snapshot.data![index].callerPic == null
                                ? ""
                                : snapshot.data![index].callerPic!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )),
                  title: Text(
                    snapshot.data![index].callerUid ==
                            profileController.currentUser.value.id
                        ? snapshot.data![index].receiverName!
                        : snapshot.data![index].callerName!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    formattedTime,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  trailing: snapshot.data![index].type == "video"
                      ? IconButton(
                          icon: Icon(Icons.video_call),
                          onPressed: () {},
                        )
                      : IconButton(
                          icon: Icon(Icons.call),
                          onPressed: () {},
                        ),
                );
              },
            );
          } else {
            return Center(
              child: Container(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
