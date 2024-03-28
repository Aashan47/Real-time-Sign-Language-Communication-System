import 'package:flutter/material.dart';
import 'package:login_app/screens/texttovoice.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/screens/BlankScreen.dart';
import 'package:login_app/screens/home_screen.dart';
import 'voice_text_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:login_app/screens/main_screen.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:login_app/screens/intermediate_flip_card/intermediate_flip_card_widget.dart';
import 'package:login_app/screens/voicetotext.dart';
import 'package:login_app/screens/texttovoice.dart';
import 'package:login_app/screens/main_screen.dart';
import 'package:login_app/screens/webrtc.dart';


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

class VoicetoText extends StatefulWidget {
  const VoicetoText({super.key});
  static String id = 'voicetotext';

  @override
  State<VoicetoText> createState() => _VoicetoTextState();

}


class _VoicetoTextState extends State <VoicetoText> {

  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;
  String _wordsSpoken = "";
  double _confidenceLevel = 0;

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _confidenceLevel = 0;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = "${result.recognizedWords}";
      _confidenceLevel = result.confidence;
    });
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
                    'Speech To Text',
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
          children: [

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
                            Icons.voice_chat,
                            size: 40,
                          ),
                          SizedBox(width: 10), // Add space between icon and text
                          Text(
                            'Voice',
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TexttoVoice()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 30),
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
                            'Text',
                            style: TextStyle(
                              fontSize: 20, // Set the desired font size
                            ),
                          ),
                          SizedBox(width: 10), // Add space between text and icon
                          Icon(
                            Icons.text_fields,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),





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
                  child: SingleChildScrollView(
                  child: Text(
                    _wordsSpoken,
                    textAlign: TextAlign.left, // Center the text within the container
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),



            if (_speechToText.isNotListening && _confidenceLevel > 0)
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 100,
                ),
                // child: Text(
                //   "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
                //   style: TextStyle(
                //     fontSize: 30,
                //     fontWeight: FontWeight.w200,
                //   ),
                // ),
              )
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
              FloatingActionButton(
                onPressed: _speechToText.isListening ? _stopListening : _startListening,
                tooltip: 'Listen',
                backgroundColor: Color.fromRGBO(152,94,211, 1.0),
                child: Animate(
                  effects: [FadeEffect(), ScaleEffect()],
                  child: Icon(
                    _speechToText.isNotListening ? Icons.mic_off_sharp : Icons.mic_none_sharp,
                    size: 28.0,
                    color: Colors.white,
                  ),
                  // backgroundColor: Colors.red,
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