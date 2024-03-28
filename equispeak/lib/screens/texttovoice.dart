import 'package:flutter/material.dart';
import 'package:login_app/screens/voicetotext.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/screens/BlankScreen.dart';
import 'package:login_app/screens/home_screen.dart';
import 'voice_text_chat_screen.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:login_app/screens/main_screen.dart';
import 'package:login_app/screens/intermediate_flip_card/intermediate_flip_card_widget.dart';
import 'package:login_app/screens/voicetotext.dart';
import 'package:login_app/screens/texttovoice.dart';
import 'package:login_app/screens/main_screen.dart';
import 'package:login_app/screens/webrtc.dart';


class TexttoVoice extends StatefulWidget {
  const TexttoVoice({super.key});
  static String id = 'texttovoice';

  @override
  State<TexttoVoice> createState() => _TexttoVoice();

}


class CustomNotchedShape extends NotchedShape {
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..quadraticBezierTo(host.width / 2, host.height + 10, host.width, host.bottom)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..lineTo(host.left, host.top);
  }
}

class _TexttoVoice extends State<TexttoVoice> {
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0), // Set preferred height of the app bar
        child: AppBar(
          backgroundColor: const Color.fromRGBO(247,246,254,1.0), // Set the background color of the app bar to light purple
          elevation: 3, // Set the elevation of the app bar
          automaticallyImplyLeading: false, // Remove the back arrow button
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30.0), // Make the bottom corners rounded
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0), // Add top padding to move items downwards
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(0.0), // Add padding to the leading widget
                  child: Image(
                    image: AssetImage(
                      'assets/images/Person.png', // Correct the path to your local asset
                    ),
                    fit: BoxFit.cover,
                    width: 40, // Adjust the width of the image
                    height: 50, // Adjust the height of the image
                  ),
                ),
                const SizedBox(width: 16.0), // Add space between image and text
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Text To Speech',
                    style: TextStyle(
                      color: const Color.fromRGBO(152,94,211, 1.0), // Set the color of the text to white
                      fontSize: 20.0 * MediaQuery.of(context).textScaleFactor, // Dynamic font size
                    ),
                  ),
                ),
                const Spacer(), // Use spacer to push the options button to the right
                Padding(
                  padding: const EdgeInsets.only(right: 0.0), // Adjust the padding as needed
                  child: PopupMenuButton(
                    icon: const Icon(Icons.more_vert, color: Color.fromRGBO(152, 94, 211, 1.0)),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        value: 'logout',
                        child: Container(
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              color: Color.fromRGBO(152, 94, 211, 1.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Set curved edges
                    ),
                    onSelected: (value) {
                      if (value == 'logout') {
                        Navigator.pushReplacementNamed(context, HomeScreen.id);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),



      body: Center(
        child: Column(
          children :[

            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the row horizontally
                  children: [
                    // Wrap icon and text for "Voice" inside a container
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromRGBO(152, 94, 211, 1.0)), // Purple border
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                      padding: EdgeInsets.all(10), // Add padding to create space between border and content
                      child: Row(
                        children: [
                          Icon(
                            Icons.text_fields,
                            size: 40,
                          ),
                          SizedBox(width: 10), // Add space between icon and text
                          Text(
                            'Text',
                            style: TextStyle(
                              fontSize: 20, // Set the desired font size
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Add space between the two sets of icon and text
                    // SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the desired page when the icon is pressed
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VoicetoText()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 20),
                        child: Icon(
                          Icons.swap_horiz_outlined,
                          color: Color.fromRGBO(152, 94, 211, 1.0),
                          size: 40,
                        ),
                      ),
                    ),



                    // Wrap icon and text for "Text" inside a container
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromRGBO(152, 94, 211, 1.0)), // Purple border
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                      padding: EdgeInsets.all(10), // Add padding to create space between border and content


                      child: Row(
                        children: [
                          Text(
                            'Voice',
                            style: TextStyle(
                              fontSize: 20, // Set the desired font size
                            ),
                          ),
                          SizedBox(width: 10), // Add space between text and icon
                          Icon(
                            Icons.voice_chat,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),


            const SizedBox(height: 50), // Add space between boxes
            // const Padding(
            //   padding: EdgeInsets.fromLTRB(0, 0, 210, 0),
            // ),
            const SizedBox(height: 45),

            Expanded(
              child: Center(
                child: Container(
                  width: 350, // Set a static width for the container
                  height: 400,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color.fromRGBO(152, 94, 211, 1.0)), // Deep purple border
                  ),
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
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(30),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Enter your text here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey), // Default border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.purple), // Focused border color
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.purple, // Icon color
                    ),
                    onPressed: () {
                      speakText(_textEditingController.text);
                      setState(() {
                        chatMessages.add(_textEditingController.text);
                        _textEditingController.clear();
                      });
                    },
                  ),
                ),
              ),
            ),


          ],
        ),
      ),


      bottomNavigationBar: BottomAppBar(
        color: Colors.white, // Set the background color of the bottom navigation bar to white
        elevation: 0, // Remove the elevation
        shape: CustomNotchedShape(), // Use custom notch shape with purple border
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0), // Add vertical padding
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color.fromRGBO(152,94,211, 1.0), width: 2.0)), // Add deep purple color border on top edge
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home_outlined, size: 28.0, color: Color.fromRGBO(152,94,211, 1.0)), // Set icon size and color
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()), // Replace VoiceToTextScreen() with your actual screen widget
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt_outlined, size: 26.0, color: Color.fromRGBO(152,94,211, 1.0)), // Set icon size and color
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => P2PVideo()), // Replace VoiceToTextScreen() with your actual screen widget
                  );
                },
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  color: Color.fromRGBO(152,94,211, 1.0),
                  padding: EdgeInsets.all(5),
                  child: IconButton(
                    icon: const Icon(
                        Icons.mic_none_sharp,
                        size: 33.0,
                        color: Colors.white
                    ), // Set icon size and color
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VoicetoText()), // Replace VoiceToTextScreen() with your actual screen widget
                      );
                    },
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.flip_to_front, size: 27.0, color: Color.fromRGBO(152,94,211, 1.0)), // Set icon size and color
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IntermediateFlipCardWidget()), // Replace VoiceToTextScreen() with your actual screen widget
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.account_circle_outlined, size: 27.0, color: Color.fromRGBO(152,94,211, 1.0)), // Set icon size and color
                onPressed: () {
                  // Handle profile button press
                },
              ),
            ],
          ),
        ),
      ),



    );
  }
}