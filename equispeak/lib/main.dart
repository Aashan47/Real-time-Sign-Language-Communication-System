import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(EquiSpeakApp());
}

class EquiSpeakApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EquiSpeak',
      theme: ThemeData.dark(),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MiddleScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 232, 232),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Path to your custom logo image
              width: 120.0,
              height: 120.0,
            ),
            SizedBox(height: 16.0),
            Text(
              'EquiSpeak',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 5, 4, 4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiddleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 243, 243),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Option !',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 5, 5, 5),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
              child: Text(
                'Voice/Text Chat',
                style: TextStyle(fontSize: 18.0),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                primary:
                    Color.fromARGB(255, 10, 95, 117), // Button background color
                onPrimary: Color.fromARGB(255, 238, 233, 233), // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController textController = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText speech = stt.SpeechToText();
  List<String> chatMessages = [];

  bool listening = false; // Track whether we are currently listening

  Future<void> convertTextToSpeech(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.speak(text);
  }

  Future<void> convertSpeechToText() async {
    if (await speech.initialize()) {
      await speech.listen(
        onResult: (result) {
          setState(() {
            textController.text = result.recognizedWords;
          });
        },
      );
    } else {
      print('Speech recognition not available');
    }
  }

  void addMessage(String message) {
    setState(() {
      chatMessages.add(message);
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EquiSpeak Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(chatMessages[index]),
                );
              },
            ),
          ),
          Divider(height: 1.0),
          ListTile(
            leading: LongPressButton(
              onPressed: () {
                setState(() {
                  listening = true;
                });
                convertSpeechToText();
              },
              onLongPressUp: () {
                setState(() {
                  listening = false;
                });
                speech.stop(); // Stop listening when button is released
              },
              child: Text('Listen'),
            ),
            title: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(),
              ),
            ),
            trailing: TextButton(
              onPressed: () {
                final message = textController.text;
                if (message.isNotEmpty) {
                  addMessage(message);
                  convertTextToSpeech(message);
                  textController.clear();
                }
              },
              child: Text('Send'),
            ),
          ),
        ],
      ),
    );
  }
}

class LongPressButton extends StatefulWidget {
  final VoidCallback onPressed;
  final VoidCallback onLongPressUp;
  final Widget child;

  LongPressButton(
      {required this.onPressed,
      required this.onLongPressUp,
      required this.child});

  @override
  _LongPressButtonState createState() => _LongPressButtonState();
}

class _LongPressButtonState extends State<LongPressButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onLongPressUp();
      },
      child: Container(
        color: _isPressed ? Colors.blue.withOpacity(0.7) : null,
        child: widget.child,
      ),
    );
  }
}
