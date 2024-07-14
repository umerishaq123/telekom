import 'dart:typed_data'; // Import for Uint8List
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;

class PDFViewerScreen extends StatelessWidget {
  final String pdfUrl;

  const PDFViewerScreen({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('PDF URL: $pdfUrl'); // Print the PDF URL for debugging

    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: FutureBuilder<Uint8List>(
        future: _loadPDF(pdfUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
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
      final response = await http.get(Uri.parse(pdfUrl));
      if (response.statusCode == 200) {
        return Uint8List.fromList(response.bodyBytes);
      } else {
        throw ('Failed to load PDF: ${response.statusCode}');
      }
    } catch (e) {
      throw ('Failed to load PDF: $e');
    }
  }
}
