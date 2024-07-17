import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telekom2/main.dart';
import 'package:telekom2/screens/new_chat_module/constants.dart';
import 'package:telekom2/screens/new_chat_module/view/screens/search_screen.dart';

import '../../model/user.dart';
import '../../provider/firebase_provider.dart';
import '../../service/firebase_firestore_service.dart';
import '../../service/notification_service.dart';
import '../widgets/user_item.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> with WidgetsBindingObserver {
  // final notificationService = NotificationsService();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.microtask(() {
      Provider.of<FirebaseProvider>(context, listen: false).getAllUsers();
    });

    // notificationService.firebaseNotification(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        FirebaseFirestoreService.updateUserData({
          'lastActive': DateTime.now(),
          'isOnline': true,
        });
        break;

      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        FirebaseFirestoreService.updateUserData({'isOnline': false});
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          // backgroundColor: mainColor,
          backgroundColor: Colors.white,
          title: const Text('Chats',style: TextStyle(fontSize: 24),),
          centerTitle: true,
          // actions: [
          //   IconButton(
          //     onPressed: () => Navigator.of(context).push(
          //         MaterialPageRoute(builder: (_) => const UsersSearchScreen())),
          //     icon: const Icon(Icons.search, color: Colors.black),
          //   ),
          // ],
        ),
        body: Consumer<FirebaseProvider>(builder: (context, value, child) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: value.users.length,
             separatorBuilder: (context, index) => Divider(), 
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                value.users[index].uid != GetMeEmail.senderId
                    ? UserItem(user: value.users[index])
                    : const SizedBox(),
                    
          );
        }),
      );
}
