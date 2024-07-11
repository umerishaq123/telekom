import 'package:flutter/material.dart';
import 'package:telekom2/screens/chats/widgets/ChatScreen.dart';
import 'package:telekom2/screens/chats/widgets/model/ChatItem.dart';
import 'package:telekom2/utils/ImathPaths.dart';


class BuddyConnectorScreen extends StatelessWidget {
  const BuddyConnectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final List<ChatItem> chatItems = [
      ChatItem(
        profileUrl: 'https://images.unsplash.com/photo-1518739005966-3a39d6d87103?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        name: 'John Doe',
        time: '10:30 AM',
        lastMessage: 'Hey, how are you?',
      ),
      ChatItem(
        profileUrl: 'https://images.unsplash.com/photo-1475609471617-0ef53b59cff5?q=80&w=1376&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        name: 'Jane Smith',
        time: '11:00 AM',
        lastMessage: 'Let\'s catch up later!',
      ),
      ChatItem(
        profileUrl: 'https://images.unsplash.com/photo-1518739005966-3a39d6d87103?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        name: 'John Doe',
        time: '10:30 AM',
        lastMessage: 'Hey, how are you?',
      ),
      ChatItem(
        profileUrl: 'https://images.unsplash.com/photo-1475609471617-0ef53b59cff5?q=80&w=1376&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        name: 'Jane Smith',
        time: '11:00 AM',
        lastMessage: 'Let\'s catch up later!',
      ),
      ChatItem(
        profileUrl: 'https://images.unsplash.com/photo-1518739005966-3a39d6d87103?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        name: 'John Doe',
        time: '10:30 AM',
        lastMessage: 'Hey, how are you?',
      ),
      ChatItem(
        profileUrl: 'https://images.unsplash.com/photo-1475609471617-0ef53b59cff5?q=80&w=1376&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        name: 'Jane Smith',
        time: '11:00 AM',
        lastMessage: 'Let\'s catch up later!',
      ),
      ChatItem(
        profileUrl: 'https://images.unsplash.com/photo-1518739005966-3a39d6d87103?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        name: 'John Doe',
        time: '10:30 AM',
        lastMessage: 'Hey, how are you?',
      ),
      ChatItem(
        profileUrl: 'https://images.unsplash.com/photo-1475609471617-0ef53b59cff5?q=80&w=1376&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        name: 'Jane Smith',
        time: '11:00 AM',
        lastMessage: 'Let\'s catch up later!',
      ),
      ChatItem(
        profileUrl: 'https://images.unsplash.com/photo-1518739005966-3a39d6d87103?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        name: 'John Doe',
        time: '10:30 AM',
        lastMessage: 'Hey, how are you?',
      ),
      ChatItem(
        profileUrl: 'https://images.unsplash.com/photo-1475609471617-0ef53b59cff5?q=80&w=1376&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        name: 'Jane Smith',
        time: '11:00 AM',
        lastMessage: 'Let\'s catch up later!',
      ),
      ChatItem(
        profileUrl: 'https://images.unsplash.com/photo-1518739005966-3a39d6d87103?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        name: 'John Doe',
        time: '10:30 AM',
        lastMessage: 'Hey, how are you?',
      ),
      ChatItem(
        profileUrl: 'https://images.unsplash.com/photo-1475609471617-0ef53b59cff5?q=80&w=1376&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        name: 'Jane Smith',
        time: '11:00 AM',
        lastMessage: 'Let\'s catch up later!',
      ),
      ChatItem(
        profileUrl: 'https://images.unsplash.com/photo-1518739005966-3a39d6d87103?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        name: 'John Doe',
        time: '10:30 AM',
        lastMessage: 'Hey, how are you?',
      ),
      ChatItem(
        profileUrl: 'https://images.unsplash.com/photo-1475609471617-0ef53b59cff5?q=80&w=1376&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        name: 'Jane Smith',
        time: '11:00 AM',
        lastMessage: 'Let\'s catch up later!',
      ),
      ChatItem(
        profileUrl: 'https://images.unsplash.com/photo-1518739005966-3a39d6d87103?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        name: 'John Doe',
        time: '10:30 AM',
        lastMessage: 'Hey, how are you?',
      ),
      ChatItem(
        profileUrl: 'https://images.unsplash.com/photo-1475609471617-0ef53b59cff5?q=80&w=1376&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        name: 'Jane Smith',
        time: '11:00 AM',
        lastMessage: 'Let\'s catch up later!',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: TextButton(
          onPressed: () {},
          child: Text(
            'Edits',
            // style: GoogleFonts.inter(
            //   textStyle: const TextStyle(color: Colors.black, fontSize: 13),
            // ),
          ),
        ),
        title: const Text("Chats"),
        actions: [
          GestureDetector(
            child: const Image(
              image: AssetImage(ImagePaths.tickicon),
              width: 20,
              height: 20,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const SizedBox(
              width: 30.0, // Set the width of the icon
              height: 30.0, // Set the height of the icon
              child: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: screenWidth * 0.9,
                  height: 40,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Color(0xFFD9D9D9),
                  ),
                  child: const TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Positioned(left: 110, top: 9, child: Icon(Icons.search))
              ],
            ),
            const SizedBox(height: 10), // Add spacing between the search bar and the list
            Expanded(
              child: ListView.builder(
                itemCount: chatItems.length,
                itemBuilder: (context, index) {
                  final item = chatItems[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(item.profileUrl),
                    ),
                    title: Text(item.name),
                    subtitle: Text(item.lastMessage),
                    trailing: Text(item.time),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(chatItem: item ,profileUrl:  item.profileUrl,),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


