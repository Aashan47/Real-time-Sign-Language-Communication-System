import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/screens/BlankScreen.dart';
import 'package:login_app/screens/alphabets/alphabets_widget.dart';
import 'package:login_app/screens/home_screen.dart';
import 'package:login_app/screens/texttovoice.dart';
import 'voice_text_chat_screen.dart';
import 'voicetotext.dart';
import 'package:login_app/screens/alphabets/alphabets_model.dart';
import 'package:login_app/screens/alphabets/alphabets_widget.dart';
import 'package:login_app/screens/intermediate_flip_card/intermediate_flip_card_model.dart';
import 'package:login_app/screens/intermediate_flip_card/intermediate_flip_card_widget.dart';
import 'package:login_app/screens/webrtc.dart';

import 'package:login_app/screens/intermediate_flip_card/intermediate_flip_card_widget.dart';
import 'package:login_app/screens/voicetotext.dart';
import 'package:login_app/screens/texttovoice.dart';

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

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key});
  static String id = 'main_screen';
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
                    'Welcome Back',
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10), // Add space between text and box 1
            Container(
              width: MediaQuery.of(context).size.width - 60, // Adjust the width of the box
              height: 160, // Adjust the height of the box
              decoration: BoxDecoration(
                color: const Color.fromRGBO(253,244,227,1.0), // Set background color for box 1
                borderRadius: BorderRadius.circular(30.0), // Set rounded border
                border: Border.all(
                  color: const Color.fromRGBO(239,222,180,1.0), // Set border color for box 1
                  width: 2.0, // Set border width
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0), // Add padding to the text
                    child: Container(
                      width: 160, // Set the width of the container for the text
                      child: const Text(
                        'Now translate sign language using your camera',
                        textAlign: TextAlign.left, // Align text to the left
                        style: TextStyle(
                          color: Colors.black, // Set text color to black
                          fontSize: 10.0, // Set font size
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 18,
                    right: 35,
                    child: Container(
                      height: 110,
                      child: Image.asset(
                          'assets/images/sign_icon.png',
                        color: Color.fromRGBO(152,94,211, 1.0),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 48,
                    left: 18,
                    child: Text(
                      "Scan Signs",
                        style: TextStyle(
                          color: Color.fromRGBO(152,94,211, 1.0), // Set text color to black
                          fontSize: 22.0, // Set font size
                        ),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 15,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => P2PVideo()), // Replace VoiceToTextScreen() with your actual screen widget
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange, // Set button background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0), // Set button border radius
                        ),
                      ),
                      child: const Text(
                        'Translate Now',
                        style: TextStyle(
                          color: Colors.white, // Set button text color
                          fontSize: 14.0, // Set button text size
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),



            const SizedBox(height: 20), // Add space between boxes
            // const Padding(
            //   padding: EdgeInsets.fromLTRB(0, 0, 250, 0),
            //   child: Text(
            //     'Voice to Text',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 18.0,
            //     ),
            //   ),
            // ),

            const SizedBox(height: 10), // Add space between text and box 2

            Container(
              width: MediaQuery.of(context).size.width - 60, // Adjust the width of the box
              height: 160, // Adjust the height of the box
              decoration: BoxDecoration(
                color: const Color.fromRGBO(253,244,227,1.0), // Set background color for box 1
                borderRadius: BorderRadius.circular(30.0), // Set rounded border
                border: Border.all(
                  color: const Color.fromRGBO(239,222,180,1.0), // Set border color for box 1
                  width: 2.0, // Set border width
                ),
              ),
            child: Stack(
              children: [
                const Positioned(
                  top: 18,
                  left: 20,
                  child: Text(
                    "Voice/Text Chat",
                    style: TextStyle(
                      color: Color.fromRGBO(152,94,211, 1.0), // Set text color to black
                      fontSize: 20.0, // Set font size
                    ),
                  ),
                ),

                Positioned(
                  top: 18,
                  right: 30,
                  child: Container(
                    height: 110,
                    child: Image.asset(
                      'assets/images/voice_text_chat.png',
                      color: Color.fromRGBO(152,94,211, 1.0),
                    ),
                  ),
                ),


                Positioned(
                  top: 45,
                  left: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VoicetoText()), // Replace VoiceToTextScreen() with your actual screen widget
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange, // Set button background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0), // Set button border radius
                      ),
                    ),
                    child: const Text(
                      'Voice to Text',
                      style: TextStyle(
                        color: Colors.white, // Set button text color
                        fontSize: 14.0, // Set button text size
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 15,
                  left: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TexttoVoice()), // Replace VoiceToTextScreen() with your actual screen widget
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange, // Set button background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0), // Set button border radius
                      ),
                    ),
                    child: const Text(
                      'Text to Voice',
                      style: TextStyle(
                        color: Colors.white, // Set button text color
                        fontSize: 14.0, // Set button text size
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


            const SizedBox(height: 10), // Add space between text and box 2



            const SizedBox(height: 20), // Add space between boxes
            // const Padding(
            //   padding: EdgeInsets.fromLTRB(0, 0, 210, 0),
            //   child: Text(
            //     'Flip Card Support',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 18.0,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 10), // Add space between text and box 2

        Container(
          width: MediaQuery.of(context).size.width - 60, // Adjust the width of the box
          height: 160, // Adjust the height of the box
          decoration: BoxDecoration(
            color: const Color.fromRGBO(253,244,227,1.0), // Set background color for box 1
            borderRadius: BorderRadius.circular(30.0), // Set rounded border
            border: Border.all(
              color: const Color.fromRGBO(239,222,180,1.0), // Set border color for box 1
              width: 2.0, // Set border width
            ),
          ),
          child:  Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0), // Add padding to the text
                child: SizedBox(
                  width: 180, // Set the width of the container for the text
                  child: Text(
                    'Explore sign language alphabets with engaging flip card lessons.',
                    textAlign: TextAlign.left, // Align text to the left
                    style: TextStyle(
                      color: Colors.black, // Set text color to black
                      fontSize: 10.0, // Set font size
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 18,
                left: 20,
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange, // Set button background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Set button border radius
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IntermediateFlipCardWidget()), // Replace VoiceToTextScreen() with your actual screen widget
                    );
                  },
                  child: const Text(
                    'Flip Card Support',
                    style: TextStyle(
                      color: Colors.white, // Set button text color
                      fontSize: 14.0, // Set button text size
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 50,
                left: 18,
                child: Text(
                  "Flip Card Support",
                  style: TextStyle(
                    color: Color.fromRGBO(152,94,211, 1.0), // Set text color to black
                    // color: Colors.black,
                    fontSize: 20.0, // Set font size
                  ),
                ),
              ),


              Positioned(
                top: 18,
                right: 30,
                child: Container(
                  height: 110,
                  child: Image.asset(
                    'assets/images/flip_card.png',
                    color: Color.fromRGBO(152,94,211, 1.0),
                  ),
                ),
              ),





            ],
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



      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () {
      //         // Add your action here
      //       },
      //       child: const Icon(Icons.add),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () {
      //         // Add your action here
      //       },
      //       child: const Icon(Icons.edit),
      //     ),
      //   ],
      // ),
    );
  }
}
