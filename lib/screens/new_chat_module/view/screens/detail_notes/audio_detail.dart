
import 'dart:io';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerScreen({Key? key, required this.audioUrl}) : super(key: key);

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {

  @override
  Widget build(BuildContext context) {
    print("::: the url is hare :${widget.audioUrl}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Audio Player',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images.png'), // Replace with your image asset
            SizedBox(height: 20),
            AudioPlayerWidget(widget.audioUrl)
         
          ],
        ),
      ),
    );
  }
}




class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;
  AudioPlayerWidget(this.audioUrl);
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool showVolumeSlider = false;
  double currentVolume = 0.5;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // Request audio focus
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());

    // Listen to changes in playback state
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        isPlaying = state.playing;
      });
    });

    // Listen to changes in playback position
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        currentPosition = position;
      });
    });

    // Listen to changes in the duration of the audio
    _audioPlayer.durationStream.listen((duration) {
      setState(() {
        totalDuration = duration ?? Duration.zero;
      });
    });

    // Load the audio source
    await _audioPlayer.setUrl(widget.audioUrl);
  }

  void _playPause() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  void _skipForward() {
    final newPosition = currentPosition + Duration(seconds: 10);
    _audioPlayer.seek(newPosition);
  }

  void _setVolume(double value) {
    setState(() {
      currentVolume = value;
      _audioPlayer.setVolume(value);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Column(
          children: [
            
            // Audio Progress Bar
            Slider(
              
              value: currentPosition.inMilliseconds.toDouble(),
              onChanged: (double value) {
                _audioPlayer.seek(Duration(milliseconds: value.toInt()));
              },
              min: 0.0,
              max: totalDuration.inMilliseconds.toDouble(),
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
            ),
            // Control Icons
            Row(
              children: [
                IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: _playPause,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: _skipForward,
                ),
                IconButton(
                  icon: Icon(Icons.volume_up),
                  onPressed: () {
                    setState(() {
                      showVolumeSlider = !showVolumeSlider;
                    });
                  },
                ),
               if (showVolumeSlider)
                  Container(
                    width: 100, // Adjust the width as needed
                    child: Slider(
                      value: currentVolume,
                      onChanged: _setVolume,
                      min: 0.0,
                      max: 1.0,
                    ),
                  ),
                   Text(_formatDuration(currentPosition)),
                    Text('/${_formatDuration(totalDuration)}'),
                  
              ],
            ),
            // Audio Time Display
           
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

