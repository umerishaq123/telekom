// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:http/http.dart' as http;
// import 'package:share/share.dart';
// import 'package:telekom2/utils/app_constant.dart'; // Import the correct share package

// class PDFViewerScreen extends StatelessWidget {
//   final String pdfUrl;

//   const PDFViewerScreen({Key? key, required this.pdfUrl}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     print('PDF URL: $pdfUrl'); // Print the PDF URL for debugging

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Notes',
//           style: TextStyle(fontSize: 18),
//         ),
//         actions: [
//           PopupMenuButton(itemBuilder: (BuildContext context){
//             return <PopupMenuEntry>[
//               PopupMenuItem(child: Text('Share')),
//               PopupMenuItem(child: Text('Download'))
//             ];
//           })
//         //   Center(
//         //     child: InkWell(
//         //       onTap: () async {
//         //         try {
//         //           final pdfBytes = await _loadPDF(pdfUrl);
//         //           await _sharePDF(pdfBytes);
//         //         } catch (e) {
//         //           print("Error sharing PDF: $e");
//         //         }
//         //       },
//         //       child: Container(
//         //         margin: EdgeInsets.only(right: 10),
//         //         height: MediaQuery.of(context).size.height * 0.03,
//         //         width: MediaQuery.of(context).size.width * 0.2,
//         //         decoration: ShapeDecoration(
//         //           color: Colors.white,
//         //           shape: RoundedRectangleBorder(
//         //             borderRadius: BorderRadius.circular(5),
//         //           ),
//         //           shadows: AppConstantsWidgetStyle.kShadows,
//         //         ),
//         //         child: Center(child: Text('Share')),
//         //       ),
//         //     ),
//         //   )
//         ],
//         centerTitle: true,
//       ),
//       body: FutureBuilder<Uint8List>(
//         future: _loadPDF(pdfUrl),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             print("::: the error is :${snapshot.error}");
//             return Center(child: Text('Error loading PDF: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             return SfPdfViewer.memory(
//               snapshot.data!,
//             );
//           } else {
//             return Center(child: Text('Unknown error occurred.'));
//           }
//         },
//       ),
//     );
//   }

//   // Import for Uri.decodeComponent

//   Future<Uint8List> _loadPDF(String pdfUrl) async {
//     try {
//       if (pdfUrl.startsWith('http')) {
//         // Handle remote PDF
//         final response = await http.get(Uri.parse(pdfUrl));
//         if (response.statusCode == 200) {
//           return Uint8List.fromList(response.bodyBytes);
//         } else {
//           throw ('Failed to load PDF: ${response.statusCode}');
//         }
//       } else {
//         // Handle local PDF
//         final localPath = Uri.decodeComponent(pdfUrl.replaceFirst(
//             'file://', '')); // Decode URL-encoded characters
//         final file = File(localPath);
//         print(
//             "Checking file existence at: $localPath"); // Log path for debugging
//         if (await file.exists()) {
//           return await file.readAsBytes();
//         } else {
//           throw ('Local file does not exist');
//         }
//       }
//     } catch (e) {
//       print("::: error:$e");
//       throw ('Failed to load PDF: $e');
//     }
//   }

//   Future<void> _sharePDF(Uint8List pdfBytes) async {
//     try {
//       // Get the temporary directory
//       final directory = await getTemporaryDirectory();
//       final pdfFile = File('${directory.path}/pdf_file.pdf');

//       // Write the PDF bytes to the file
//       await pdfFile.writeAsBytes(pdfBytes);

//       // Share the file
//       await Share.shareFiles([pdfFile.path], text: 'Check out this PDF!');
//     } catch (e) {
//       print("Error sharing PDF: $e");
//     }
//   }
// }

// import 'dart:io';
// import 'dart:typed_data';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:http/http.dart' as http;
// import 'package:share/share.dart';
// import 'package:telekom2/utils/app_constant.dart';
// import 'package:telekom2/utils/utils.dart';

// class PDFViewerScreen extends StatelessWidget {
//   final String pdfUrl;

//   const PDFViewerScreen({Key? key, required this.pdfUrl}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     print('PDF URL: $pdfUrl'); // Print the PDF URL for debugging

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Notes',
//           style: TextStyle(fontSize: 18),
//         ),
//         actions: [
//           PopupMenuButton<String>(
//             onSelected: (value) async {
//               if (value == 'share') {
//                 try {
//                   final pdfBytes = await _loadPDF(pdfUrl);
//                   await _sharePDF(pdfBytes);
//                 } catch (e) {
//                   print("Error sharing PDF: $e");
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Error sharing PDF: $e'),
//                     ),
//                   );
//                 }
//               } else if (value == 'download') {
//                 try {

//                   final pdfBytes = await _loadPDF(pdfUrl);
//                   await _savePDF(pdfBytes,context);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('PDF downloaded successfully!'),
//                     ),
//                   );
//                 } catch (e) {
//                   print("Error downloading PDF: $e");
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Error downloading PDF: $e'),
//                     ),
//                   );
//                 }
//               }
//             },
//             itemBuilder: (BuildContext context) {
//               return <PopupMenuEntry<String>>[
//                 PopupMenuItem<String>(
//                   value: 'share',
//                   child: Text('Share'),
//                 ),
//                 PopupMenuItem<String>(
//                   value: 'download',
//                   child: Text('Download'),
//                 ),
//               ];
//             },
//           ),
//         ],
//         centerTitle: true,
//       ),
//       body: FutureBuilder<Uint8List>(
//         future: _loadPDF(pdfUrl),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             print("::: the error is :${snapshot.error}");
//             return Center(child: Text('Error loading PDF: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             return SfPdfViewer.memory(
//               snapshot.data!,
//             );
//           } else {
//             return Center(child: Text('Unknown error occurred.'));
//           }
//         },
//       ),
//     );
//   }

//   Future<Uint8List> _loadPDF(String pdfUrl) async {
//     try {
//       if (pdfUrl.startsWith('http')) {
//         // Handle remote PDF
//         final response = await http.get(Uri.parse(pdfUrl));
//         if (response.statusCode == 200) {
//           return Uint8List.fromList(response.bodyBytes);
//         } else {
//           throw ('Failed to load PDF: ${response.statusCode}');
//         }
//       } else {
//         // Handle local PDF
//         final localPath = Uri.decodeComponent(pdfUrl.replaceFirst(
//             'file://', '')); // Decode URL-encoded characters
//         final file = File(localPath);
//         print(
//             "Checking file existence at: $localPath"); // Log path for debugging
//         if (await file.exists()) {
//           return await file.readAsBytes();
//         } else {
//           throw ('Local file does not exist');
//         }
//       }
//     } catch (e) {
//       print("::: error:$e");
//       throw ('Failed to load PDF: $e');
//     }
//   }

//   Future<void> _sharePDF(Uint8List pdfBytes) async {
//     try {
//       // Get the temporary directory
//       final directory = await getTemporaryDirectory();
//       final pdfFile = File('${directory.path}/pdf_file.pdf');

//       // Write the PDF bytes to the file
//       await pdfFile.writeAsBytes(pdfBytes);

//       // Share the file
//       await Share.shareFiles([pdfFile.path], text: 'Check out this PDF!');
//     } catch (e) {
//       print("Error sharing PDF: $e");
//       throw ('Error sharing PDF: $e');
//     }
//   }

//  Future<void> _savePDF(Uint8List pdfBytes,BuildContext context) async {
//   try {
//     final status = await Permission.storage.request();
//     if (status.isGranted) {
//       final directory = await getExternalStorageDirectory(); // For Android
//       if (directory != null) {
//         final pdfFile = File('${directory.path}/pdf_file.pdf');
//         await pdfFile.writeAsBytes(pdfBytes);
//         ScaffoldMessenger.of(context ).showSnackBar(
//           SnackBar(
//             content: Text('PDF saved to ${pdfFile.path}'),
//           ),
//         );
//       } else {
//         throw ('Failed to get external storage directory');
//       }
//     } else {
//       throw ('Storage permission denied');
//     }
//   } catch (e) {
//     print("Error saving PDF: $e");
//     // ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//     //   SnackBar(
//     //     content: Text('Error saving PDF: $e'),
//     //   ),
//     Utils.snackBar('Error saving PDF: $e', context);

//   }
// }

// }

import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:telekom2/utils/app_constant.dart';
import 'package:telekom2/utils/utils.dart';

class PDFViewerScreen extends StatelessWidget {
  final String pdfUrl;

  const PDFViewerScreen({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('PDF URL: $pdfUrl'); // Print the PDF URL for debugging

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'share') {
                try {
                  final pdfBytes = await _loadPDF(pdfUrl);
                  await _sharePDF(pdfBytes);
                } catch (e) {
                  print("Error sharing PDF: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error sharing PDF: $e'),
                    ),
                  );
                }
              } else if (value == 'download') {
                try {
                  await downloadFile(
                    context: context,
                    fileUrl: pdfUrl,
                    fileName: 'file.pdf', // Optional: specify the file name
                  );
                } catch (e) {
                  print("Error downloading PDF: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error downloading PDF: $e'),
                    ),
                  );
                }
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'share',
                  child: Text('Share'),
                ),
                PopupMenuItem<String>(
                  value: 'download',
                  child: Text('Download'),
                ),
              ];
            },
          ),
        ],
        centerTitle: true,
      ),
      body: FutureBuilder<Uint8List>(
        future: _loadPDF(pdfUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("::: the error is :${snapshot.error}");
            return Center(child: Text('Error loading PDF: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return SfPdfViewer.memory(
              snapshot.data!,
            );
          } else {
            return Center(child: Text('Unknown error occurred.'));
          }
        },
      ),
    );
  }

  Future<Uint8List> _loadPDF(String pdfUrl) async {
    try {
      if (pdfUrl.startsWith('http')) {
        // Handle remote PDF
        final response = await http.get(Uri.parse(pdfUrl));
        if (response.statusCode == 200) {
          return Uint8List.fromList(response.bodyBytes);
        } else {
          throw ('Failed to load PDF: ${response.statusCode}');
        }
      } else {
        // Handle local PDF
        final localPath = Uri.decodeComponent(pdfUrl.replaceFirst(
            'file://', '')); // Decode URL-encoded characters
        final file = File(localPath);
        print(
            "Checking file existence at: $localPath"); // Log path for debugging
        if (await file.exists()) {
          return await file.readAsBytes();
        } else {
          throw ('Local file does not exist');
        }
      }
    } catch (e) {
      print("::: error:$e");
      throw ('Failed to load PDF: $e');
    }
  }

  Future<void> _sharePDF(Uint8List pdfBytes) async {
    try {
      // Get the temporary directory
      final directory = await getTemporaryDirectory();
      final pdfFile = File('${directory.path}/pdf_file.pdf');

      // Write the PDF bytes to the file
      await pdfFile.writeAsBytes(pdfBytes);

      // Share the file
      await Share.shareFiles([pdfFile.path], text: 'Check out this PDF!');
    } catch (e) {
      print("Error sharing PDF: $e");
      throw ('Error sharing PDF: $e');
    }
  }

  Future<void> downloadFile({
    required BuildContext context,
    required String fileUrl,
    String fileName = 'file.pdf',
  }) async {
    Map<Permission, PermissionStatus> statuses = await [
                    Permission.storage,
                    //add more permission to request here.
                  ].request();

                  if(statuses[Permission.storage]!.isGranted){
                    var dir = await getExternalStorageDirectory();
                    if(dir != null){
                      String savename = "file.pdf";
                      String savePath = dir.path + "/$savename";
                      print(savePath);
                      //output:  /storage/emulated/0/Download/banner.png

                      try {
                        await Dio().download(
                            fileUrl,
                            savePath,
                            onReceiveProgress: (received, total) {
                              if (total != -1) {
                                print((received / total * 100).toStringAsFixed(0) + "%");
                                //you can build progressbar feature too
                              }
                            });
                        print("File is saved to download folder.");
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("File Downloaded"),
                        ));
                      } on DioError catch (e) {
                        print(e.message);
                      }
                    }
                  }else{
                    print("No permission to read and write.");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Permission Denied !"),
                    ));
                  }

                }
  }

