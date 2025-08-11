import 'package:flutter/material.dart';
import 'breath_meditation.dart';
import 'mantra_meditation.dart';
import 'yoga_nidra.dart';
import 'chakra_cleaning.dart';
import 'aura_healing.dart';

class HomePage extends StatelessWidget {
  final String userName;

  HomePage({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back button
        title: Text(
          '~ Way to Nirvaan ~',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontFamily: 'Georgia',
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade800, Colors.blue.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 8,
        shadowColor: Colors.black45,
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
            MeditationTopicCard(
              title: 'Breath Meditation',
              image: 'assets/images/OIP (2).jpeg',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BreathMeditation()),
                );
              },
            ),
            MeditationTopicCard(
              title: 'Mantra Meditation',
              image: 'assets/images/OIP (1).jpeg',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MantraMeditation()),
                );
              },
            ),
            MeditationTopicCard(
              title: 'Yoga Nidra',
              image: 'assets/images/OIP (3).jpeg',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => YogaNidra()),
                );
              },
            ),
            MeditationTopicCard(
              title: 'Chakra Cleaning',
              image: 'assets/images/OIP (4).jpeg',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChakraCleaning()),
                );
              },
            ),
            MeditationTopicCard(
              title: 'Aura Healing',
              image: 'assets/images/R.jpeg',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuraHealing()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MeditationTopicCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  MeditationTopicCard({required this.title, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
