import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:login_app/screens/BlankScreen.dart';
import 'package:login_app/screens/home_screen.dart';
import 'package:login_app/screens/login_screen.dart';
import 'package:login_app/screens/signup_screen.dart';
import 'package:login_app/screens/voicetotext.dart';
import 'package:login_app/screens/webrtc.dart';
import 'package:login_app/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_app/screens/voice_text_chat_screen.dart';
import 'package:login_app/screens/microphone_screen.dart';
import 'package:login_app/screens/main_screen.dart';
import 'package:login_app/screens/texttovoice.dart';
import 'package:login_app/screens/webrtc.dart';
import 'package:login_app/screens/voicetotext.dart';
// import 'package:login_app/screens/liveGesture.dart';
import 'package:login_app/screens/BlankScreen.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/nav/nav.dart';
import 'package:login_app/screens/alphabets/alphabets_widget.dart';
import 'package:login_app/screens/alphabets/alphabets_model.dart';


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
        BlankScreen.id:(context) => BlankScreen(),
        MicrophoneScreen.id: (context) => MicrophoneScreen(),
        MainScreen.id: (context) => MainScreen(),
        VoicetoText.id: (context) => VoicetoText(),
        TexttoVoice.id: (context) => TexttoVoice(),
        BlankScreen.id: (context) => P2PVideo(),
        //GestureRecognitionScreen.id: (context) => GestureRecognitionScreen(),
        },
    );
  }
}
