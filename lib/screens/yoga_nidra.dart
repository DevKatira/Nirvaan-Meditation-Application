import 'package:flutter/material.dart';
import 'dart:async';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YogaNidra extends StatefulWidget {
  @override
  _YogaNidraState createState() => _YogaNidraState();
}

class _YogaNidraState extends State<YogaNidra> {
  int _secondsRemaining = 600; //
  Timer? _timer;
  bool _isRunning = false;

  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'GX8TPloZLRQ',
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
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
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
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
        title: Text('🧘 Yoga Nidra'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.greenAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Image.asset('assets/images/OIP (3).jpeg', height: 250, width: double.infinity, fit: BoxFit.cover),
            SizedBox(height: 20),
            MeditationContentCard(
              color: Colors.pinkAccent,
              title: '📖 Description',
              content: 'Yoga Nidra, or "yogic sleep," 💤 is a guided meditation practice that involves deep relaxation and visualization. 🧘‍♂️✨\n\n'
                  'It helps bring the body into a state of consciousness between waking and sleeping 🌓, allowing profound rest and healing. 💙',
            ),
            MeditationContentCard(
              color: Colors.blueAccent,
              title: '🌟 Advantages',
              content: '✅ Reduces stress and anxiety, promoting deep relaxation. 😌\n\n'
                  '✅ Enhances sleep quality and helps with insomnia. 🛌💤\n\n'
                  '✅ Boosts self-awareness and emotional regulation. 🧠💡\n\n'
                  '✅ Supports mental clarity and improves focus. 🎯',
            ),
            MeditationContentCard(
              color: Colors.teal,
              title: '🛤️ Steps',
              content: '1️⃣ Find a quiet place 🌿 and lie down on your back in a comfortable position.\n\n'
                  '2️⃣ Close your eyes 😌 and take a few deep breaths to relax your body and mind. 🌬️\n\n'
                  '3️⃣ Follow a guided Yoga Nidra session 🎧, which typically includes a body scan, breath awareness, and visualization. 🌀\n\n'
                  '4️⃣ Let go of any tension and allow yourself to enter a deep meditative state. ✨💆\n\n'
                  '🕒 Start with a **20-30 minute** session and gradually increase the duration for deeper relaxation. ⏳',
            ),
            SizedBox(height: 20),
            // Video Section
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
                      ' Yoga Nidra Guided Meditation',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Timer Section
            Card(
              color: Colors.purpleAccent,
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
                      'Meditation Timer',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _formatTime(_secondsRemaining),
                      style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _isRunning ? null : _startTimer,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          child: Text('Start', style: TextStyle(fontSize: 18)),
                        ),
                        ElevatedButton(
                          onPressed: _isRunning ? _stopTimer : null,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child: Text(' Stop', style: TextStyle(fontSize: 18)),
                        ),
                        ElevatedButton(
                          onPressed: _resetTimer,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                          child: Text(' Reset', style: TextStyle(fontSize: 18)),
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
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
