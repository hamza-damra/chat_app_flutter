import 'package:firebase_chat_app/screens/chat_page.dart';
import 'package:firebase_chat_app/screens/login_page.dart';
import 'package:firebase_chat_app/screens/register_page.dart';
import 'package:firebase_chat_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBOxCEJNDKyWMimSl7O5mRPzfnW_nt7gVM",
        appId: "1:971984740794:android:d7dafa2eeaa7fa23b93d83",
        messagingSenderId: "971984740794",
        projectId: "flutterfirebase-bb764",
      ),
    );
    runApp(const MyApp());
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set SplashScreen as the initial route
      home: SplashScreen(),
      routes: {
        // Define the routes for your app
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ChatPage.id: (context) => ChatPage(),
        // SplashScreen.id: (context) => SplashScreen(), // Not needed as home already points to SplashScreen
      },
    );
  }
}
