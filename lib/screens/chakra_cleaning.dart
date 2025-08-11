import 'package:flutter/material.dart';
import 'dart:async';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart'; // For screen rotation control

class ChakraCleaning extends StatefulWidget {
  @override
  _ChakraCleaningState createState() => _ChakraCleaningState();
}

class _ChakraCleaningState extends State<ChakraCleaning> {
  int _secondsRemaining = 600; // 10 minutes in seconds
  Timer? _timer;
  bool _isRunning = false;

  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'I6jP5oLdKpY', // Chakra Cleaning video ID
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    _youtubeController.addListener(() {
      if (!_youtubeController.value.isFullScreen) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); // Lock to portrait
      }
    });
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    _timer?.cancel();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); // Restore portrait mode
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer!.cancel();
        setState(() {
          _isRunning = false;
        });
      }
    });
    setState(() {
      _isRunning = true;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _secondsRemaining = 600;
      _isRunning = false;
    });
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🔮 Chakra Cleaning', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.purple,
        centerTitle: true,
        elevation: 5,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.greenAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Image.asset('assets/images/OIP (4).jpeg', height: 250, fit: BoxFit.cover),
            SizedBox(height: 20),


            MeditationContentCard(
              color: Colors.pinkAccent,
              title: '📖 What is Chakra Cleaning?',
              content: '✨ Chakra Cleaning meditation helps balance and align the energy centers of the body for improved well-being. It promotes spiritual, emotional, and physical harmony. 🌿',
            ),

            // 🌟 Advantages
            MeditationContentCard(
              color: Colors.blue,
              title: '🌟 Benefits of Chakra Cleaning',
              content: '✅ Enhances emotional balance 💖\n'
                  '✅ Clears energy blockages 🚀\n'
                  '✅ Increases spiritual awareness 🧘‍♂️\n'
                  '✅ Boosts overall well-being 🌿\n'
                  '✅ Helps in deep relaxation 😌',
            ),

            // 🛤️ Steps
            MeditationContentCard(
              color: Colors.teal,
              title: '🛤️ Step-by-Step Guide',
              content: '1️⃣ Sit in a comfortable position with a straight spine.\n'
                  '2️⃣ Close your eyes and take deep breaths 😌.\n'
                  '3️⃣ Visualize each chakra, starting from the root to the crown 🌈.\n'
                  '4️⃣ Imagine a bright healing light cleansing each chakra ✨.\n'
                  '5️⃣ Focus on positive energy flowing through your body 🌊.\n'
                  '6️⃣ Continue for 10 minutes and feel the energy balance 🌀.',
            ),

            SizedBox(height: 20),


            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Guided Chakra Cleaning Video', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        height: 200,
                        child: YoutubePlayer(
                          controller: _youtubeController,
                          showVideoProgressIndicator: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            Card(
              color: Colors.purpleAccent,
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(' Meditation Timer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 10),
                    Text(_formatTime(_secondsRemaining), style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _isRunning ? null : _startTimer,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          child: Text('Start'),
                        ),
                        ElevatedButton(
                          onPressed: _isRunning ? _stopTimer : null,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child: Text(' Stop'),
                        ),
                        ElevatedButton(
                          onPressed: _resetTimer,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                          child: Text(' Reset'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MeditationContentCard extends StatelessWidget {
  final Color color;
  final String title;
  final String content;

  MeditationContentCard({required this.color, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
