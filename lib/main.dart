import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'screens/login_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/home.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(NirvaanApp());
}

class NirvaanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nirvaan Meditation App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/  ',
      debugShowCheckedModeBanner: false, // Remove the debug banner
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signin': (context) => SignInScreen(),
        '/home': (context) => HomePage(userName: 'User'),
      },
    );
  }
}
