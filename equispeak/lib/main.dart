import 'package:flutter/material.dart';
import 'package:login_app/screens/camera_page.dart';
import 'package:login_app/screens/home_screen.dart';
import 'package:login_app/screens/login_screen.dart';
import 'package:login_app/screens/signup_screen.dart';
import 'package:login_app/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_app/screens/voice_text_chat_screen.dart';
import 'package:login_app/screens/microphone_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'Ubuntu',
        ),
      )),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        VoiceTextChatScreen.id: (context) => VoiceTextChatScreen(),
        MicrophoneScreen.id: (context) => MicrophoneScreen(),
        CameraPage.id: (context) => CameraPage(),

      },
    );
  }
}
