import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> names = [
      'Alice',
      'Bob',
      'Charlie',
      'David',
      'Eve',
      'Frank',
      'Grace',
      'Hannah',
      'Isaac',
      'Jack'
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            TextButton(
              onPressed: () {},
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  Text(
                    "Back",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 60,
            ),
            const Text(
              "Notes",
              textAlign: TextAlign.center,
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 18.0 ,top: 8 ,bottom: 8),

            child: Text("All Voice Converted Lectures "),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      child: Text(names[index] ,textAlign: TextAlign.center,)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
