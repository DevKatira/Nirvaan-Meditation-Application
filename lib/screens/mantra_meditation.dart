import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:async';

class MantraMeditation extends StatefulWidget {
  @override
  _MantraMeditationState createState() => _MantraMeditationState();
}

class _MantraMeditationState extends State<MantraMeditation> {
  int _secondsRemaining = 600; // 10 minutes in seconds
  Timer? _timer;
  bool _isRunning = false;
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId("https://youtu.be/vbVh43mTHF4")!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        controlsVisibleAtStart: false,
        disableDragSeek: false,
        hideControls: false,
        loop: false,
        forceHD: false,
      ),
    );
  }

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
        title: Text(
          '🕉️ Mantra Meditation',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
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
            Image.asset(
              'assets/images/OIP (1).jpeg',
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),

            MeditationContentCard(
              color: Colors.blueAccent,
              title: '📖 Description',
              content:
              'Mantra meditation is a powerful technique where you silently repeat a word, phrase, or sound to enhance focus and spiritual growth. 🧘‍♂️ It helps quiet the mind and deepen concentration.',
            ),
            SizedBox(height: 10),

            MeditationContentCard(
              color: Colors.green,
              title: '🌟 Advantages',
              content:
              '✅ Enhances concentration and mental clarity 🧠\n'
                  '✅ Promotes relaxation and inner peace ☮️\n'
                  '✅ Strengthens spiritual awareness ✨',
            ),
            SizedBox(height: 10),

            MeditationContentCard(
              color: Colors.orangeAccent,
              title: '🛤️ Steps',
              content:
              '1️⃣ Find a peaceful place and sit in a comfortable position. 🪑\n\n'
                  '2️⃣ Choose a mantra (e.g., "Om"). 🔊\n\n'
                  '3️⃣ Close your eyes and start repeating the mantra silently. 👀\n\n'
                  '4️⃣ Focus on the vibration and sound of the mantra. 🎶\n\n'
                  '5️⃣ If your mind wanders, gently bring your attention back to the mantra. 🔄\n\n'
                  'Start with 10 minutes and gradually extend your practice. ⏳',
            ),
            SizedBox(height: 20),

            // Video Card with fullscreen icon removed
            Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Mantra Meditation Video',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    YoutubePlayerBuilder(
                      player: YoutubePlayer(
                        controller: _youtubeController,
                        showVideoProgressIndicator: true,
                        topActions: [
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _youtubeController.metadata.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      builder: (context, player) {
                        return player;
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Timer Card
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
                      'Meditation Timer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _formatTime(_secondsRemaining),
                      style: TextStyle(
                        fontSize: 40,
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: Text('Start'),
                        ),
                        ElevatedButton(
                          onPressed: _isRunning ? _stopTimer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text('Stop'),
                        ),
                        ElevatedButton(
                          onPressed: _resetTimer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                          ),
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

  MeditationContentCard({
    required this.color,
    required this.title,
    required this.content,
  });

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
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
