import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telkom/utils/ImathPaths.dart';
import 'model/ChatItem.dart';

class ChatScreen extends StatefulWidget {
  final ChatItem chatItem;
  final String profileUrl;


  const ChatScreen({super.key, required this.chatItem, required this.profileUrl});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String text) {
    if (text.isEmpty) return;
    final message = Message(text: text, isSentByMe: true);
    setState(() {
      _messages.add(message);
    });
    _controller.clear();
    _simulateReply();
  }

  void _simulateReply() {
    Future.delayed(const Duration(seconds: 1), () {
      final message = Message(text: 'Reply to: ${_messages.last.text}', isSentByMe: false);
      setState(() {
        _messages.add(message);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Handle back button press
              },
            ),

          ],
        ),
        title: Text(widget.chatItem.name ,style: TextStyle(fontSize: 16 ,fontFamily: GoogleFonts.inter().debugLabel ,fontWeight: FontWeight.w800),),
        centerTitle: true,
        actions: [

          Container(
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle

            ),
            child: CircleAvatar(

              backgroundImage: NetworkImage(widget.profileUrl),
            ),
          ),

          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle action button press
            },
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: Image.asset(
                    ImagePaths.backimage, // Replace with your image URL
                    fit: BoxFit.cover,
                  ),
                ),
                // Chat Content
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[_messages.length - 1 - index];
                          return Align(
                            alignment: message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: message.isSentByMe ? Colors.blue : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                message.text,
                                style: TextStyle(color: message.isSentByMe ? Colors.white : Colors.black),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2.0), // Adjust the color and width as needed
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.mic_none, color: Colors.black),
                      onPressed: () => _sendMessage(_controller.text),
                    ),
                  ),
                )
                // IconButton(
                //   icon: Icon(Icons.send),
                //   onPressed: () => _sendMessage(_controller.text),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isSentByMe;

  Message({required this.text, required this.isSentByMe});
}
