import 'dart:io';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:telekom2/provider/image_to_text.dart';
import 'package:telekom2/screens/chats/widgets/model/image_to_text_model.dart';
import 'package:telekom2/screens/new_chat_module/view/widgets/image_to_text.dart';
import 'package:telekom2/utils/ColorPath.dart';
import 'package:http/http.dart' as http;

class ScreenReaderScreen extends StatefulWidget {
  const ScreenReaderScreen({Key? key}) : super(key: key);

  @override
  _ScreenReaderScreenState createState() => _ScreenReaderScreenState();
}

class _ScreenReaderScreenState extends State<ScreenReaderScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  bool isProcessing = false;
  int processingPercentage = 0;
  Future<ImagetotextModel>? viewimagetotextinfo;
  late ImageToTextProvider _imageToTextProvider;
  String? audioFilePath;
   bool showAudioPlayer = false; 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _imageToTextProvider =
        Provider.of<ImageToTextProvider>(context, listen: false);
  }

  @override
  void dispose() {
    flutterTts.stop();
    Future.microtask(() => _resetState());
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      _processImage();
    }
  }

  Future<void> _processImage() async {
    if (_selectedImage != null) {
      setState(() {
        isProcessing = true;
        processingPercentage = 0;
      });

      // Simulate image processing and updating progress
      for (int i = 0; i <= 100; i++) {
        await Future.delayed(Duration(milliseconds: 50));
        setState(() {
          processingPercentage = i;
        });
      }

      try {
        await Provider.of<ImageToTextProvider>(context, listen: false)
            .processImage(_selectedImage!);

        setState(() {
          isProcessing = false;
        });
      } catch (error) {
        setState(() {
          isProcessing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _speak(String text) async {
    try {
        final tempDir = await Directory.systemTemp.createTemp();
  final tempFile = File('${tempDir.path}/tts_audio.m4a');
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);
      await flutterTts.setVolume(1.0);
      await flutterTts.synthesizeToFile(text, tempFile.path);
      setState(() {
        isPlaying = true;
         showAudioPlayer = true;
    audioFilePath = tempFile.path;
      });
      await flutterTts.speak(text);
    } catch (e) {
      print("Error while speaking: $e");
    }
  }

  Future<void> _pause() async {
    await flutterTts.pause();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<ImageToTextProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Text Reader",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 30),
              GestureDetector(
                onTap: _showImageSourceDialog,
                child: SizedBox(
                  width: screenWidth * 0.6,
                  height: screenWidth * 0.6,
                  child: _selectedImage == null
                      ? const Image(image: AssetImage("assets/lens.png"))
                      : Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 30),
              if (isProcessing) ...[
                SizedBox(
                  width: screenWidth * 0.9,
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        minHeight: 25,
                        value: processingPercentage / 100,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colorpath.buttonColor2),
                      ),
                      const SizedBox(height: 10),
                      Text('$processingPercentage%'),
                    ],
                  ),
                ),
              ] else if (provider.imageToText != null) ...[
                SizedBox(
                  width: screenWidth * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isPlaying) {
                        _pause();
                      } else {
                        if (provider.imageToText?.extractedText != null) {
                          String text = provider.imageToText!.extractedText!;
                          _speak(text);
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colorpath.buttonColor2),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(top: 13, bottom: 13),
                        child: Text('Play')),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Imagetotext(),
                          ));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colorpath.buttonColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 13, bottom: 13),
                      child: Text(
                        "Read",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
                if (showAudioPlayer && audioFilePath != null) ...[
                const SizedBox(height: 20),
                AudioPlayerWidget(audioFilePath: audioFilePath!),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _resetState() {
    setState(() {
      _selectedImage = null;
      isPlaying = false;
      isProcessing = false;
      processingPercentage = 0;
      _imageToTextProvider.clearText();
    });
  }
}


class AudioPlayerWidget extends StatefulWidget {
  final String audioFilePath;
  AudioPlayerWidget({required this.audioFilePath, Key? key});
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
    await _audioPlayer.setUrl(widget.audioFilePath);
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
