import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
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
  @override
  void initState() {
    super.initState();
    // Fetch API data initially
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotesProvider>(context, listen: false).fetchApiData();
    });
  }

  Future<void> _pickAudioFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;
        Provider.of<NotesProvider>(context, listen: false)
            .addAudioFile(filePath);
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;

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
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                shadows: AppConstantsWidgetStyle.kShadows,
              ),
              child: Center(
                child: Text(
                  'Upload Files',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<NotesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 18.0, top: 8, bottom: 8),
                  child: Text("All Voice Converted Lectures"),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.lectures.length,
                    itemBuilder: (context, index) {
                      final item = provider.lectures[index];
                      return ListTile(
                        onTap: () {
                          final fileUrl = item.fileUrl!;
                          if (fileUrl.toLowerCase().endsWith('.pdf')) {
                            if (fileUrl.startsWith('http')) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PDFViewerScreen(
                                    pdfUrl: fileUrl,
                                  ),
                                ),
                              );
                            } else if (fileUrl.startsWith('/data/')) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PDFViewerScreen(
                                    pdfUrl: Uri.file(fileUrl).toString(),
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
                          } else if (fileUrl.toLowerCase().endsWith('.mp3')) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AudioPlayerScreen(
                                  audioUrl: fileUrl,
                                ),
                              ),
                            );
                          } else if (fileUrl.startsWith('/data/')) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AudioPlayerScreen(
                                  audioUrl: Uri.file(fileUrl).toString(),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item.details ?? 'No Details',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              PopupMenuButton<String>(
                                padding: EdgeInsets.zero,
                                onSelected: (String value) {
                                  if (value == 'delete') {
                                    provider.deleteLecture(index);
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    const PopupMenuItem<String>(
                                      value: 'delete',
                                      height: 25,
                                      child: Center(
                                          child: Text(
                                        'Delete',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ];
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
