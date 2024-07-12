
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:telekom2/screens/chats/BuddyConnectorScreen.dart';



// class NavigationMenu extends StatelessWidget {
//   const NavigationMenu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(NavigationCOntroller());
//     return Scaffold(
//       bottomNavigationBar: Obx(
//             () => NavigationBar(
//           height: 80,
//           elevation: 0,
//           selectedIndex: controller.selectedIndex.value,

//           onDestinationSelected: (index) =>
//           controller.selectedIndex.value = index,
//           destinations: const [
//             NavigationDestination(icon: Icon(Icons.contact_page), label: 'Contact'),
//             NavigationDestination(icon: Icon(Icons.chat), label: 'Chats'),
//             NavigationDestination(icon: Icon(Icons.settings), label: 'Setting'),
//           ],
//         ),
//       ),
//       body: Obx(() => controller.screens[controller.selectedIndex.value]),
//     );
//   }
// }

// // class NavigationCOntroller extends GetxController {
// //   final Rx<int> selectedIndex = 0.obs;

// //   final screens = [
// //     const BuddyConnectorScreen(),


// //     Container(
// //       color: Colors.orange,
// //     ),
// //     Container(
// //       color: Colors.orange,
// //     ),
// //     Container(
// //       color: Colors.blue,
// //     ),
// //   ];

// // }
