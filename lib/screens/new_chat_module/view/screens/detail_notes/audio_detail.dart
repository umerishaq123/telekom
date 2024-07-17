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
  double currentSliderValue = 0.0;
  double maxSliderValue = 0.0;

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
        maxSliderValue = duration.inSeconds.toDouble();
      });
    });

    audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        currentPosition = _formatDuration(position);
        currentSliderValue = position.inSeconds.toDouble();
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

  Future<void> _seekAudio(double value) async {
    await audioPlayer.seek(Duration(seconds: value.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    print("::: the url of audio is :${widget.audioUrl}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         Image.asset('assets/images.png'),
            SizedBox(height: 20),
            Row(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(8)),
                Text(currentPosition),
                Expanded(
                  child: Slider(
                    value: currentSliderValue,
                    max: maxSliderValue,
                    onChanged: (double value) {
                      setState(() {
                        currentSliderValue = value;
                      });
                      _seekAudio(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(totalDuration),
                ),
              ],
            ),
               IconButton(
              icon: Icon(
                isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                size: 50.0,
              ),
              onPressed: _playPauseAudio,
            ),
          ],
        ),
      ),
    );
  }
}
