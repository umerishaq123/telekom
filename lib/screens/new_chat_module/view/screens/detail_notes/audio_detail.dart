import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerScreen({Key? key, required this.audioUrl}) : super(key: key);

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  String currentPosition = "00:00";
  String totalDuration = "00:00";

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        totalDuration = _formatDuration(duration);
      });
    });

    audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        currentPosition = _formatDuration(position);
      });
    });

    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    audioPlayer.dispose(); // Release resources when widget is disposed
    super.dispose();
  }

  Future<void> _playPauseAudio() async {
    try {
      if (isPlaying) {
        await audioPlayer.pause();
      } else {
        
        await audioPlayer.play(UrlSource(widget.audioUrl));
      }
    } catch (e) {
      print('Audio play error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Audio play error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print("::: the url of audio is :${widget.audioUrl}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('Playing audio from:'),
            // Text(widget.audioUrl),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _playPauseAudio,
              child: Text(isPlaying ? 'Pause Audio' : 'Play Audio'),
            ),
            SizedBox(height: 20),
            Text('Current Position: $currentPosition'),
            Text('Total Duration: $totalDuration'),
          ],
        ),
      ),
    );
  }
}
