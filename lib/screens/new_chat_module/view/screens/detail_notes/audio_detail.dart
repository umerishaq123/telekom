import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerScreen({Key? key, required this.audioUrl}) : super(key: key);

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer.dispose(); // Release resources when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Playing audio from:'),
            Text(widget.audioUrl),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                audioPlayer.play(Uri.parse(widget.audioUrl) as Source); // Convert string to Uri here
              },
              child: Text('Play Audio'),
            ),
          ],
        ),
      ),
    );
  }
}
