import 'package:flutter/material.dart';
import 'dart:async';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AuraHealing extends StatefulWidget {
  @override
  _AuraHealingState createState() => _AuraHealingState();
}

class _AuraHealingState extends State<AuraHealing> {
  int _secondsRemaining = 600; // 10 minutes
  Timer? _timer;
  bool _isRunning = false;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'GMf17XktC3Q', // Updated video ID
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    if (_timer != null) _timer!.cancel();
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
    if (_timer != null) _timer!.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    if (_timer != null) _timer!.cancel();
    setState(() {
      _secondsRemaining = 600; // Reset to 10 minutes
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
        title: Text('✨ Aura Healing '),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.greenAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Image.asset('assets/images/R.jpeg', height: 250, width: double.infinity, fit: BoxFit.cover),
            SizedBox(height: 20),
            MeditationContentCard(
              color: Colors.blueAccent,
              title: '📖 What is Aura Healing?',
              content: '✨ Aura healing involves working with the energy field surrounding your body to restore balance and remove blockages. '
                  'It helps in creating a protective shield around you, keeping away negativity and enhancing spiritual well-being. 🧘‍♂️✨',
            ),
            MeditationContentCard(
              color: Colors.green,
              title: '🌟 Key Benefits',
              content: '✅ Removes negative energy 🚫\n'
                  '✅ Enhances spiritual growth 🕉️\n'
                  '✅ Promotes emotional healing 💖\n'
                  '✅ Improves mental clarity and focus 🧠💡\n'
                  '✅ Strengthens the body’s natural energy field 🌈',
            ),
            MeditationContentCard(
              color: Colors.orangeAccent,
              title: '🛤️ Steps to Practice',
              content: '1️⃣ Find a quiet space** and sit or lie comfortably. 🏡🪑\n'
                  '2️⃣ Close your eyes** and focus on your breath to relax. 🌬️\n'
                  '3️⃣ Visualize your aura** glowing around you, full of light. ✨\n'
                  '4️⃣ Use healing techniques** such as color visualization or affirmations. 🔮\n'
                  '5️⃣ Feel the energy clearing** and end by visualizing your aura shining brightly. 🔆',
            ),
            SizedBox(height: 20),
            Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      ' Guided Aura Healing Video',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.green,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' Meditation Timer',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _formatTime(_secondsRemaining),
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _isRunning ? null : _startTimer,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          child: Text(' Start'),
                        ),
                        ElevatedButton(
                          onPressed: _isRunning ? _stopTimer : null,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child: Text(' Stop'),
                        ),
                        ElevatedButton(
                          onPressed: _resetTimer,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22, // Increased font size
                fontWeight: FontWeight.bold, // Bolder text
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(
                fontSize: 20, // Larger text for visibility
                fontWeight: FontWeight.w600, // Even bolder text
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
