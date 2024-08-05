// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Communities extends StatefulWidget {
//   const Communities({super.key});

//   @override
//   State<Communities> createState() => _CommunitiesState();
// }

// class _CommunitiesState extends State<Communities> {
//   final _nameController = TextEditingController();
//   final _firestore = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;

//   Future<void> _showCreateCommunityDialog() async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Create New Community'),
//           content: TextField(
//             controller: _nameController,
//             decoration: InputDecoration(labelText: 'Community Name'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 final user = _auth.currentUser;
//                 if (user != null && _nameController.text.isNotEmpty) {
//                   try {
//                     await _firestore.collection('communities').add({
//                       'name': _nameController.text,
//                       'members': [user.uid],
//                     });
//                     _nameController.clear();
//                     Navigator.of(context).pop(); // Close the dialog
//                     setState(() {}); // Refresh the community list
//                   } catch (e) {
//                     // Handle any errors here
//                     print('Error creating community: $e');
//                   }
//                 }
//               },
//               child: Text('Create'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Text('Communities', style: TextStyle(fontSize: 18)),
//             SizedBox(width: width * 0.4),
//             Icon(Icons.camera_alt_outlined),
//             SizedBox(width: width * 0.06),
//             PopupMenuButton(
//               itemBuilder: (BuildContext context) {
//                 return <PopupMenuEntry>[
//                   PopupMenuItem(child: Text('Settings')),
//                 ];
//               },
//             )
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           InkWell(
//             onTap: _showCreateCommunityDialog,
//             child: Row(
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(left: 10),
//                   height: height * 0.05,
//                   width: width * 0.13,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     color: Colors.grey[300],
//                   ),
//                   child: Icon(Icons.groups_outlined),
//                 ),
//                 SizedBox(width: width * 0.02),
//                 Text('New Community'),
//               ],
//             ),
//           ),
//           SizedBox(height: height * 0.01),
//           Divider(color: Colors.grey[300], thickness: 5),
//           Expanded(
//             child: StreamBuilder(
//               stream: _firestore.collection('communities').snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }

//                 final communities = snapshot.data?.docs ?? [];

//                 return ListView.builder(
//                   itemCount: communities.length,
//                   itemBuilder: (context, index) {
//                     final community = communities[index];
//                     return ListTile(
//                       title: Text(community['name']),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
