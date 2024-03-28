import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/screens/BlankScreen.dart';
import 'voice_text_chat_screen.dart';
import 'main_screen.dart';
import 'package:login_app/screens/BlankScreen.dart';
import 'liveGesture.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static String id = 'welcome_screen';
  @override
  Widget build(BuildContext context) {
    double fem = 1.0; // Adjust as needed

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 800 * fem,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 10 * fem,
                top: 14 * fem,
                child: Align(
                  child: SizedBox(
                    width: 340 * fem,
                    height: 771 * fem,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20 * fem),
                        border: Border.all(color: Color(0xff000000)),
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 103 * fem,
                top: 772 * fem,
                child: Align(
                  child: SizedBox(
                    width: 154 * fem,
                    height: 5 * fem,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 91 * fem,
                top: 47 * fem,
                child: Align(
                  child: SizedBox(
                    width: 49 * fem,
                    height: 26 * fem,
                    child: Text(
                      'User 1',
                      style: TextStyle(
                        fontSize: 20 * fem,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 34 * fem,
                top: 123 * fem,
                child: Align(
                  child: SizedBox(
                    width: 285 * fem,
                    height: 180 * fem,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35 * fem),
                          border: Border.all(color: Color(0xff000000)),
                          color: Color(0xffe0eeef),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3f000000),
                              offset: Offset(0, 4 * fem),
                              blurRadius: 2 * fem,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 40 * fem, // Adjust the left position as needed
                top: 338 * fem, // Adjust the top position as needed
                child: Align(
                  child: SizedBox(
                    width: 285 * fem, // Adjust the width as needed
                    height: 180 * fem, // Adjust the height as needed
                    child: TextButton(
                      onPressed: () {
                        // Redirect to another screen when the button is pressed
                        Navigator.pushNamed(context, VoiceTextChatScreen.id);
                      },
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35 * fem),
                          border: Border.all(color: Color(0xff000000)),
                          color: Color(0xfff6e9fd),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3f000000),
                              offset: Offset(0, 4 * fem),
                              blurRadius: 2 * fem,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 34 * fem,
                top: 553 * fem,
                child: Align(
                  child: SizedBox(
                    width: 285 * fem,
                    height: 180 * fem,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35 * fem),
                          border: Border.all(color: Color(0xff000000)),
                          color: Color(0xffe0eeef),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3f000000),
                              offset: Offset(0, 4 * fem),
                              blurRadius: 2 * fem,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                // group23S8 (52:106)
                left: 30 * fem,
                top: 34 * fem,
                child: Container(
                  padding:
                      EdgeInsets.fromLTRB(10 * fem, 5 * fem, 11 * fem, 6 * fem),
                  width: 50 * fem,
                  height: 50 * fem,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff000000)),
                    color: Color(0xff259fed),
                    borderRadius: BorderRadius.circular(25 * fem),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3f000000),
                        offset: Offset(0 * fem, 4 * fem),
                        blurRadius: 2 * fem,
                      ),
                    ],
                  ),
                  child: Center(
                    // person1iHN (40:40)
                    child: SizedBox(
                      width: 29 * fem,
                      height: 39 * fem,
                      child: Image(
                        image: AssetImage(
                            'assets/images/Person.png'), // Correct the path to your local asset
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                // gesturerecognitionqct (40:49)
                left: 75 * fem,
                top: 246 * fem,
                child: InkWell(
                  onTap: () {
                    // Navigate to the "gesture recognition screen" when the area is clicked
                    Navigator.pushNamed(context, MainScreen.id);
                  },
                  child: Align(
                    child: SizedBox(
                      width: 204 * fem,
                      height: 33 * fem,
                      child: Text(
                        'Gesture Recognition',
                        style: GoogleFonts.crimsonText(
                          fontSize: 25 * fem,
                          fontWeight: FontWeight.w400,
                          height: 1.3 * fem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                // voicetextchatuMr (40:50)
                left: 96 * fem,
                top: 457 * fem,
                child: InkWell(
                  onTap: () {
                    // Navigate to the "voice_text_chat_screen" when the area is clicked
                    Navigator.pushNamed(context, VoiceTextChatScreen.id);
                  },
                  child: Align(
                    child: SizedBox(
                      width: 162 * fem,
                      height: 33 * fem,
                      child: Text(
                        'Voice/Text Chat',
                        style: GoogleFonts.crimsonText(
                          fontSize: 25 * fem,
                          fontWeight: FontWeight.w400,
                          height: 1.3 * fem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                // flipcardsupportoCL (40:52)
                left: 88 * fem,
                top: 678 * fem,
                child: Align(
                  child: SizedBox(
                    width: 177 * fem,
                    height: 33 * fem,
                    child: Text(
                      'Flip Card Support',
                      style: GoogleFonts.crimsonText(
                        fontSize: 25 * fem,
                        fontWeight: FontWeight.w400,
                        height: 1.3 * fem / fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                // gesturerecognition1tzU (40:57)
                left: 131 * fem,
                top: 149 * fem,
                child: Align(
                  child: SizedBox(
                    width: 92.31 * fem,
                    height: 80 * fem,
                    child: Image(
                      image: AssetImage(
                          'assets/images/gesture.png'), // Correct the path to your local asset
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                // voicetext1cQg (40:60)
                left: 130 * fem,
                top: 359 * fem,
                child: InkWell(
                  onTap: () {
                    // Navigate to the "voice_text_chat_screen" when the area is clicked
                    Navigator.pushNamed(context, VoiceTextChatScreen.id);
                  },
                  child: Align(
                    child: SizedBox(
                      width: 88.46 * fem,
                      height: 81 * fem,
                      child: Image(
                        image: AssetImage(
                          'assets/images/Voicetext.png', // Correct the path to your local asset
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                // flipcard1XXe (40:61)
                left: 127 * fem,
                top: 578 * fem,
                child: Align(
                  child: SizedBox(
                    width: 99.6 * fem,
                    height: 90 * fem,
                    child: Image(
                      image: AssetImage(
                          'assets/images/flipcard.png'), // Correct the path to your local asset
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                // group113kt (62:373)
                left: 219 * fem,
                top: 42 * fem,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context); // This line will navigate back to the previous screen
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    width: 100 * fem,
                    height: 35 * fem,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff000000)),
                      color: Color(0xff259fed),
                      borderRadius: BorderRadius.circular(50 * fem),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3f000000),
                          offset: Offset(0 * fem, 4 * fem),
                          blurRadius: 2 * fem,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Log Out',
                        style: GoogleFonts.crimsonText(
                          fontSize: 20 * fem,
                          fontWeight: FontWeight.w700,
                          height: 1.3 * fem / fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
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
