import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_app/components/components.dart';
import 'package:login_app/screens/welcome.dart';
import 'package:login_app/screens/voice_text_chat_screen.dart';

class MicrophoneScreen extends StatelessWidget {
  const MicrophoneScreen({Key? key});
  static String id = 'microphone_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // White background color
                        border: Border.all(color: Colors.black, width: 1), // Border styling
                        borderRadius: BorderRadius.circular(30), // Adjust the border radius as needed
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          Navigator.pushNamed(context, WelcomeScreen.id);
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 30, left: 30), // Adjust the spacing between the icon and text
                    child: Text(
                      'Voice/Text Chat',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white, // Change text color to black
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          height: 250, // Adjust the height as needed
                          width: 600,
                          child: Stack(
                            children: [
                              Align(
                                alignment: const Alignment(0, -0.5), // Slightly higher than center
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black, width: 2),
                                  ),
                                  padding: const EdgeInsets.all(12), // Adjust the padding as needed
                                  child: const Icon(
                                    Icons.mic,
                                    color: Colors.black,
                                    size: 48,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment(-0.7, 0.7),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => VoiceTextChatScreen(),
                                    ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black, width: 1),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: const Icon(
                                      Icons.message,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: const Alignment(0.7, 0.7),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}