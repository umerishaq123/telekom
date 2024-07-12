import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/user.dart';
import '../../provider/firebase_provider.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/empty_widget.dart';
import '../widgets/user_item.dart';

class UsersSearchScreen extends StatefulWidget {
  const UsersSearchScreen({Key? key}) : super(key: key);

  @override
  State<UsersSearchScreen> createState() => _UsersSearchScreenState();
}

class _UsersSearchScreenState extends State<UsersSearchScreen> {
  final controller = TextEditingController();

  final userData = [
    UserModel(
      uid: '1',
      username: 'hellooo',
      firstname: 'ummer g ',
      lastname: 'khan g',
      email: 'umer5@gmail.com',
      password: '12345678',
      confirmPassword: '12345668',
      isOnline: true,
      lastActive: DateTime.now(),
    ),
    UserModel(
      isOnline: false,
      lastActive: DateTime.now(),
      uid: '2',
      username: 'hello',
      firstname: 'ummer ',
      lastname: 'khan',
      email: 'umer@gmail.com',
      password: '12345678',
      confirmPassword: '12345668',
    ),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.black,
          title: const Text(
            'Users Search',
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              CustomTextFormField(
                controller: controller,
                hintText: 'Search',
                onChanged: (val) =>
                    Provider.of<FirebaseProvider>(context, listen: false)
                        .searchUser(val),
              ),
              Consumer<FirebaseProvider>(
                builder: (context, value, child) => Expanded(
                  child: controller.text.isEmpty
                      ? const EmptyWidget(
                          icon: Icons.search, text: 'Search of User')
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: value.search.length,
                          itemBuilder: (context, index) =>
                              value.search[index].uid !=
                                      FirebaseAuth.instance.currentUser?.uid
                                  ? UserItem(user: value.search[index])
                                  : const SizedBox(),
                        ),
                ),
              ),
            ],
          ),
        ),
      );
}
