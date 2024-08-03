// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:telekom2/provider/list_of_lecture_provider.dart';

// // import 'package:telekom2/provider/session_handling_provider.dart';
// // import 'package:telekom2/screens/new_chat_module/model/list_of_lectures.model.dart'; // Adjust based on your model setup

// // class NotesScreen extends StatefulWidget {
// //   const NotesScreen({Key? key}) : super(key: key);

// //   @override
// //   _NotesScreenState createState() => _NotesScreenState();
// // }

// // class _NotesScreenState extends State<NotesScreen> {
// //   late Future<List<Listoflecture>> viewAllLectures;

// //   @override
// //   void initState() {
// //     super.initState();
// //     viewAllLectures = Provider.of<NotesProvider>(context, listen: false).fetchApiData();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         centerTitle: true,
// //         automaticallyImplyLeading: false,
// //         title: Row(
// //           children: [
// //             TextButton(
// //               onPressed: () => Navigator.of(context).pop(),
// //               child: Row(
// //                 children: [
// //                   Icon(
// //                     Icons.arrow_back_ios,
// //                     color: Colors.black,
// //                   ),
// //                   Text(
// //                     "Back",
// //                     style: TextStyle(color: Colors.black),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(
// //               width: 60,
// //             ),
// //             const Text(
// //               "Notes",
// //               textAlign: TextAlign.center,
// //             ),
// //           ],
// //         ),
// //         actions: [
// //           IconButton(
// //             onPressed: () {},
// //             icon: const Icon(
// //               Icons.more_vert,
// //               color: Colors.black,
// //             ),
// //           ),
// //         ],
// //       ),
// //       body: FutureBuilder<List<Listoflecture>>(
// //         future: viewAllLectures,
// //         builder: (context, AsyncSnapshot<List<Listoflecture>> snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           } else if (snapshot.hasError) {
// //             return Center(child: Text('Error: ${snapshot.error}'));
// //           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
// //             return Center(child: Text('No data available.'));
// //           } else {
// //             return Column(
// //               mainAxisAlignment: MainAxisAlignment.start,
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               mainAxisSize: MainAxisSize.max,
// //               children: [
// //                 const Padding(
// //                   padding: EdgeInsets.only(left: 18.0, top: 8, bottom: 8),
// //                   child: Text("All Voice Converted Lectures "),
// //                 ),
// //                 Expanded(
// //                   child: ListView.builder(
// //                     itemCount: snapshot.data!.length,
// //                     itemBuilder: (context, index) {
// //                       return ListTile(
// //                         title: Container(
// //                           color: Colors.red,
// //                           padding: const EdgeInsets.symmetric(
// //                             vertical: 10,
// //                             horizontal: 10,
// //                           ),
// //                           child: Text(
// //                             snapshot.data![index].details ?? 'No Details',
// //                             textAlign: TextAlign.center,
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //               ],
// //             );
// //           }
// //         },
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     // Clear session when disposing the screen

// //     super.dispose();
// //   }
// // }

// import 'dart:async';
// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:telekom2/provider/list_of_lecture_provider.dart';
// import 'package:telekom2/screens/new_chat_module/model/list_of_lectures.model.dart';
// import 'package:telekom2/screens/new_chat_module/view/screens/detail_notes/audio_detail.dart';
// import 'package:telekom2/screens/new_chat_module/view/screens/detail_notes/pdf_deatil.dart';
// import 'package:telekom2/utils/app_constant.dart';

// class NotesScreen extends StatefulWidget {
//   const NotesScreen({Key? key}) : super(key: key);

//   @override
//   _NotesScreenState createState() => _NotesScreenState();
// }

// class _NotesScreenState extends State<NotesScreen> {
//   late Future<List<Listoflecture>> viewAllLectures;

//   @override
//   void initState() {
//     super.initState();
//     viewAllLectures =
//         Provider.of<NotesProvider>(context, listen: false).fetchApiData();
//   }
//   Future<void> _pickAudioFile() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//           //  type: FileType.audio,
//       );

//       // FilePickerResult? result = await FilePicker.platform.pickFiles(
//       //   type: FileType.audio,
//       // );

//       if (result != null && result.files.single.path != null) {
//         String filePath = result.files.single.path!;
//         Provider.of<NotesProvider>(context, listen: false).addAudioFile(filePath);
//       } else {
//         print("User canceled the picker or no file picked");
//       }
//     } catch (e) {
//       print("Error picking file: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error picking file: $e'),
//         ),
//       );
//     }
//   }



//   Future<void> _downloadFile(String? downloadUrl, String fileName) async {
//     if (downloadUrl == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Download URL is null'),
//         ),
//       );
//       return;
//     }

//     try {
//       final response = await http.get(Uri.parse(downloadUrl));

//       if (response.statusCode == 200) {
//         final bytes = response.bodyBytes;

//         // Get the device's download directory using path_provider
//         final directory = await getExternalStorageDirectory();
//         if (directory == null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Could not access device storage'),
//             ),
//           );
//           return;
//         }

//         // Create a File instance and save the file
//         final filePath = '${directory.path}/$fileName';
//         final file = File(filePath);
//         await file.writeAsBytes(bytes);

//         // Show a toast or message indicating successful download
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('File downloaded successfully'),
//           ),
//         );
//       } else {
//         // Handle other status codes
//         print('Download failed: ${response.statusCode}');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Download failed: ${response.statusCode}'),
//           ),
//         );
//       }
//     } catch (e) {
//       // Handle network or other errors
//       print('Download error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Download error: $e'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//      final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Row(
//                 children: [
//                   Icon(
//                     Icons.arrow_back_ios,
//                     color: Colors.black,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               width: 60,
//             ),
//             const Text(
//               "Notes",
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//         actions: [
//          InkWell(
//           onTap: _pickAudioFile,
//            child: Container(
//              margin: EdgeInsets.only(right: 10),
//                     height: height * 0.03,
//                     width: width * 0.2,
//                     decoration: ShapeDecoration(
//                         color: Colors.white,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5)),
//                         shadows: AppConstantsWidgetStyle.kShadows),
//                         child: Center(child: Text('Add Files')),
//            ),
//          )
//         ],
//       ),
//       body: FutureBuilder<List<Listoflecture>>(
//         future: viewAllLectures,
//         builder: (context, AsyncSnapshot<List<Listoflecture>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No data available.'));
//           } else {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.only(left: 18.0, top: 8, bottom: 8),
//                   child: Text("All Voice Converted Lectures "),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       final item = snapshot.data![index];
//                       return ListTile(
//                         onTap: () {
//                           print("::: the pdf url is hare:${snapshot.data?[index].fileUrl}");
//                           if (item.fileUrl!.toLowerCase().endsWith('.pdf')) {
//                             // Navigate to PDF Viewer screen
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => PDFViewerScreen(
//                                   pdfUrl: item.fileUrl!,
//                                 ),
//                               ),
//                             );
//                           } else if (item.fileUrl!
//                               .toLowerCase()
//                               .endsWith('.mp3')) {
//                             // Navigate to Audio Player screen
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => AudioPlayerScreen(
//                                   audioUrl: item.fileUrl!,
//                                 ),
//                               ),
//                             );
//                           } else if(item.fileUrl ==null) {
//                             // Handle other file types or show a message
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Unsupported file type'),
//                               ),
//                             );
//                           }
//                         },
//                         title: Container(
//                           color: Colors.red,
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 10,
//                             horizontal: 10,
//                           ),
//                           child: Text(
//                             snapshot.data![index].details ?? 'No Details',
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//       // floatingActionButton: FloatingActionButton(onPressed: (){},child: Text(),),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }





import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telekom2/provider/list_of_lecture_provider.dart';
import 'package:telekom2/screens/new_chat_module/model/list_of_lectures.model.dart';
import 'package:telekom2/screens/new_chat_module/view/screens/detail_notes/audio_detail.dart';
import 'package:telekom2/screens/new_chat_module/view/screens/detail_notes/pdf_deatil.dart';
import 'package:telekom2/utils/app_constant.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late Future<List<Listoflecture>> viewAllLectures;

  @override
  void initState() {
    super.initState();
    viewAllLectures = Provider.of<NotesProvider>(context, listen: false).fetchApiData();
  }

  Future<void> _pickAudioFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
     
      );

      if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;
        Provider.of<NotesProvider>(context, listen: false).addAudioFile(filePath);
      } else {
        print("User canceled the picker or no file picked");
      }
    } catch (e) {
      print("Error picking file: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking file: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
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
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: _pickAudioFile,
            child: Container(
              margin: EdgeInsets.only(right: 10),
              height: MediaQuery.of(context).size.height * 0.03,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                shadows: AppConstantsWidgetStyle.kShadows,
              ),
              child: Center(child: Text('Add Files')),
            ),
          ),
        ],
      ),
      body: Consumer<NotesProvider>(
        builder: (context, provider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 18.0, top: 8, bottom: 8),
                child: Text("All Voice Converted Lectures "),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.lectures.length,
                  itemBuilder: (context, index) {
                    final item = provider.lectures[index];
                    return ListTile(
                      onTap: () {
                        if (item.fileUrl!.toLowerCase().endsWith('.pdf')) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PDFViewerScreen(
                                pdfUrl: item.fileUrl!,
                              ),
                            ),
                          );
                        } else if (item.fileUrl!
                            .toLowerCase()
                            .endsWith('.mp3')) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AudioPlayerScreen(
                                audioUrl: item.fileUrl!,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Unsupported file type'),
                            ),
                          );
                        }
                      },
                      title: Container(
                        color: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Text(
                          item.details ?? 'No Details',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
