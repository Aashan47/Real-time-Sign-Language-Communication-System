import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_app/components/components.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:login_app/screens/welcome.dart';
import 'package:login_app/screens/microphone_screen.dart';

class VoiceTextChatScreen extends StatefulWidget {
  VoiceTextChatScreen({Key? key}) : super(key: key);

  static String id = 'voice_text_chat_screen';

  @override
  _VoiceTextChatScreenState createState() => _VoiceTextChatScreenState();
}

class _VoiceTextChatScreenState extends State<VoiceTextChatScreen> {
  FlutterTts flutterTts = FlutterTts();
  TextEditingController _textEditingController = TextEditingController();
  List<String> chatMessages = []; // List to store chat messages

  Future<void> speakText(String text) async {
    //await flutterTts.setSpeechRate(0.5); // Adjust speech rate as needed
    await flutterTts.setPitch(1.0); // Adjust pitch as needed
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
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
                        border: Border.all(
                            color: Colors.black, width: 1), // Border styling
                        borderRadius: BorderRadius.circular(
                            30), // Adjust the border radius as needed
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
                    padding: EdgeInsets.only(
                        top: 30,
                        bottom: 30,
                        left:
                            30), // Adjust the spacing between the icon and text
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
                  padding: const EdgeInsets.only(
                      left: 20, right: 60, top: 20, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // Chat display using ListView.builder
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: chatMessages.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: <Widget>[
                                // Display an image on the left of the message
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom:
                                          20), // Adjust the gap between the image and the message
                                  width:
                                      30, // Set the width of the image container
                                  height:
                                      30, // Set the height of the image container
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle, // Make it circular
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/Person.png'), // Replace with your image path
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left:
                                          10), // Adjust the gap between the image and the message
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Text(chatMessages[index]),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: TextField(
                                  controller: _textEditingController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your text here',
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons
                                          .send), // Replace with your desired send icon
                                      onPressed: () {
                                        speakText(_textEditingController.text);
                                        setState(() {
                                          chatMessages
                                              .add(_textEditingController.text);
                                          _textEditingController.clear();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle, // Make it circular
                                border: Border.all(
                                    color: Colors.black,
                                    width: 2), // Circular border styling
                              ),
                              child: IconButton(
                                icon: const Icon(Icons
                                    .mic), // Replace with your microphone icon
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, MicrophoneScreen.id);
                                },
                              ),
                            ),
                          ],
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
