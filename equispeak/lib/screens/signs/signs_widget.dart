import 'package:go_router/go_router.dart';
import 'package:login_app/screens/home_screen.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'signs_model.dart';
export 'signs_model.dart';
import 'package:login_app/screens/intermediate_flip_card/intermediate_flip_card_widget.dart';
import 'package:login_app/screens/voicetotext.dart';
import 'package:login_app/screens/texttovoice.dart';
import 'package:login_app/screens/main_screen.dart';
import 'package:login_app/screens/webrtc.dart';

class SignsWidget extends StatefulWidget {
  const SignsWidget({super.key});

  @override
  State<SignsWidget> createState() => _SignsWidgetState();
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

class _SignsWidgetState extends State<SignsWidget> {
  late SignsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignsModel());
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
        backgroundColor: Colors.white,
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


          body: Builder(
            builder: (context) {
              return SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/image_1.png',
                                width: 150.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'A',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/imageb.png',
                                width: 100.0,
                                height: 220.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'B',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/imagec.png',
                                width: 180.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'C',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/imaged.svg',
                                width: 150.0,
                                height: 290.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'D',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/imagee.png',
                                width: 180.0,
                                height: 280.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'E',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/imagef.svg',
                                width: 150.0,
                                height: 290.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'F',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/imageg.svg',
                                width: 280.0,
                                height: 150.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'G',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/imageh.png',
                                width: 310.0,
                                height: 150.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'H',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/imagei.png',
                                width: 150.0,
                                height: 250.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'I',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/imagej.svg',
                                width: 210.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'J',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/imagek.svg',
                                width: 150.0,
                                height: 300.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'K',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/imageL.svg',
                                width: 180.0,
                                height: 250.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'L',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/imageM.svg',
                                width: 150.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'M',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/imagen.svg',
                                width: 140.0,
                                height: 210.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'N',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/imageo.svg',
                                width: 150.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'O',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/imageP.svg',
                                width: 190.0,
                                height: 120.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'P',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/imageQ.svg',
                                width: 150.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'Q',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/imageR.svg',
                                width: 130.0,
                                height: 250.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'R',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/imageS.png',
                                width: 150.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'S',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/imageT.svg',
                                width: 150.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'T',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/imageU.svg',
                                width: 100.0,
                                height: 220.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'U',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/7tz9w_V.png',
                                width: 100.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'V',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/imageW.svg',
                                width: 100.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'W',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/pjc3t_X.png',
                                width: 140.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'X',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/7mwfs_Y.png',
                                width: 180.0,
                                height: 160.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'Y',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              25.0, 25.0, 25.0, 5.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            front: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/imageZ.svg',
                                width: 150.0,
                                height: 220.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDF4E3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'Z',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF753EFB),
                                        fontSize: 50.0,
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
            },
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
