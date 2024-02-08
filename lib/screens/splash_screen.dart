// splash_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import 'chat_page.dart'; // Adjust the import path as needed
import 'login_page.dart'; // Adjust the import path as needed

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  void _navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 1)); // 3-second delay
    // Navigate based on authentication status
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushReplacementNamed(context, LoginPage.id);
    } else {
      Navigator.pushReplacementNamed(context, ChatPage.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display your app's logo or any other graphic you prefer
            Image.asset('assets/images/scholar.png', width: 120, height: 120),
            const SizedBox(height: 20),
            const Text(
              'Scholar Chat',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
          ],
        ),
      ),
    );
  }
}
