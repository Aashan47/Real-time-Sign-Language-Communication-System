import 'package:go_router/go_router.dart';
import 'package:login_app/screens/alphabets/alphabets_widget.dart';
import 'package:login_app/screens/signs/signs_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'intermediate_flip_card_model.dart';
export 'intermediate_flip_card_model.dart';
import 'package:login_app/screens/home_screen.dart';
import 'package:login_app/screens/intermediate_flip_card/intermediate_flip_card_widget.dart';
import 'package:login_app/screens/voicetotext.dart';
import 'package:login_app/screens/texttovoice.dart';
import 'package:login_app/screens/main_screen.dart';
import 'package:login_app/screens/webrtc.dart';

class IntermediateFlipCardWidget extends StatefulWidget {
  const IntermediateFlipCardWidget({super.key});

  @override
  State<IntermediateFlipCardWidget> createState() =>
      _IntermediateFlipCardWidgetState();
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

class _IntermediateFlipCardWidgetState
    extends State<IntermediateFlipCardWidget> {
  late IntermediateFlipCardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IntermediateFlipCardModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFF7F5FD),


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
                      'Flip Card Support',
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




        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(50.0, 100.0, 40.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(50.0, 50.0, 20.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignsWidget()), // Replace VoiceToTextScreen() with your actual screen widget
                      );
                    },
                    text: 'Signs ',
                    icon: const FaIcon(
                      FontAwesomeIcons.angleDoubleRight,
                    ),
                    options: FFButtonOptions(
                      width: 200.0,
                      height: 164.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: const Color(0xFF753EFB),
                      textStyle:
                          FlutterFlowTheme.of(context).titleLarge.override(
                                fontFamily: 'Outfit',
                                color: const Color(0xFFFDF4E3),
                              ),
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(50.0, 50.0, 20.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AlphabetsWidget()), // Replace VoiceToTextScreen() with your actual screen widget
                      );
                    },
                    text: 'Alphabets',
                    icon: const FaIcon(
                      FontAwesomeIcons.angleDoubleRight,
                    ),
                    options: FFButtonOptions(
                      width: 200.0,
                      height: 164.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: const Color(0xFF753EFB),
                      textStyle:
                          FlutterFlowTheme.of(context).titleLarge.override(
                                fontFamily: 'Outfit',
                                color: const Color(0xFFFDF4E3),
                              ),
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ],
            ),
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

      ),
    );
  }
}
