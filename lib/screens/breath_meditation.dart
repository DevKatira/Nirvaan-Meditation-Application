import 'package:flutter/material.dart';
import 'dart:async';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BreathMeditation extends StatefulWidget {
  @override
  _BreathMeditationState createState() => _BreathMeditationState();
}

class _BreathMeditationState extends State<BreathMeditation> {
  int _secondsRemaining = 600;
  Timer? _timer;
  bool _isRunning = false;

  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();

    _youtubeController = YoutubePlayerController(
      initialVideoId: 'VUjiXcfKBn8',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
        controlsVisibleAtStart: true,
        forceHD: true,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    _timer?.cancel();
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
        title: Text('💨 Breath Meditation', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 5,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.yellow],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Image.asset('assets/images/OIP (2).jpeg', height: 250, fit: BoxFit.cover),
            SizedBox(height: 20),

            MeditationContentCard(
              color: Colors.blueAccent,
              title: '🧘 Description',
              content: 'Breath meditation involves focusing on your breath 🌬️ to achieve a state of calm 😌 and mindfulness 🧠.',
            ),
            MeditationContentCard(
              color: Colors.green,
              title: '✨ Advantages',
              content: '✔️ Reduces stress and anxiety 😌\n'
                  '✔️ Improves focus and concentration 🎯\n'
                  '✔️ Promotes relaxation and better sleep 😴',
            ),
            MeditationContentCard(
              color: Colors.orangeAccent,
              title: '📌 Steps',
              content: '1️⃣  Find a quiet place and sit comfortably 🪑.\n'
                  '2️⃣ Close your eyes 👀 and take a few deep breaths 🌬️.\n'
                  '3️⃣ Focus on your breath 🔄.\n'
                  '4️⃣  Count your breaths 1️⃣ 2️⃣ 3️⃣.\n'
                  '5️⃣ If distracted, gently return focus to your breath 🧘.',
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
                    Text('Guided Meditation Video', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        height: 200,
                        child: YoutubePlayer(
                          controller: _youtubeController,
                          showVideoProgressIndicator: true,
                          onReady: () {
                            print('Player is ready.');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            Card(
              color: Colors.green,
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Meditation Timer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 10),
                    Text(_formatTime(_secondsRemaining), style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _isRunning ? null : _startTimer,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          child: Text('Start'),
                        ),
                        ElevatedButton(
                          onPressed: _isRunning ? _stopTimer : null,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child: Text('Stop'),
                        ),
                        ElevatedButton(
                          onPressed: _resetTimer,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                          child: Text('Reset'),
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
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
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