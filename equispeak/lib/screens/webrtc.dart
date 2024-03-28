import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:login_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:http/http.dart' as http;
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

class P2PVideo extends StatefulWidget {
  const P2PVideo({Key? key}) : super(key: key);

  @override
  // State<VoicetoText> createState() => _VoicetoTextState();
  State<P2PVideo> createState() => _P2PVideoState();
}

class _P2PVideoState extends State<P2PVideo> {
  RTCPeerConnection? _peerConnection;
  final _localRenderer = RTCVideoRenderer();

  MediaStream? _localStream;
  String _prediction = '';
  String _prevPrediction = '';
  RTCDataChannelInit? _dataChannelDict;
  RTCDataChannel? _dataChannel;
  String transformType = "none";

  // MediaStream? _localStream;
  bool _inCalling = false;

  DateTime? _timeStart;

  bool _loading = false;

  // void _onTrack(RTCTrackEvent event) {
    // print("TRACK EVENT: ${event.streams.map((e) => e.id)}, ${event.track.id}");
    // if (event.track.kind == "video") {
    //   print("HERE");
    //   _localRenderer.srcObject = event.streams[0];
    // }
  // }

  void _onDataChannelState(RTCDataChannelState? state) {
    switch (state) {
      case RTCDataChannelState.RTCDataChannelClosed:
        print("Camera Closed!!!!!!!");
        break;
      case RTCDataChannelState.RTCDataChannelOpen:
        print("Camera Opened!!!!!!!");
        break;
      default:
        print("Data Channel State: $state");
    }
  }

  Future<bool> _waitForGatheringComplete(_) async {
    print("WAITING FOR GATHERING COMPLETE");
    if (_peerConnection!.iceGatheringState ==
        RTCIceGatheringState.RTCIceGatheringStateComplete) {
      return true;
    } else {
      await Future.delayed(Duration(seconds: 1));
      return await _waitForGatheringComplete(_);
    }
  }

  // void _toggleCamera() async {
  //   if (_localStream == null) throw Exception('Stream is not initialized');
  //
  //   final videoTrack = _localRenderer.srcObject!
  //       .getVideoTracks()
  //       .firstWhere((track) => track.kind == 'video');
  //   await Helper.switchCamera(videoTrack);
  // }

  Future<void> _negotiateRemoteConnection() async {
    return _peerConnection!
        .createOffer()
        .then((offer) {
      return _peerConnection!.setLocalDescription(offer);
    })
        .then(_waitForGatheringComplete)
        .then((_) async {
      var des = await _peerConnection!.getLocalDescription();
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
        'POST',
        Uri.parse(
            'https://85ba-2407-d000-a-f30f-536-cb98-23e9-f5dd.ngrok-free.app/offer'), // CHANGE URL HERE TO LOCAL SERVER
      );
      request.body = json.encode(
        {
          "sdp": des!.sdp,
          "type": des.type,
          "video_transform": transformType,
        },
      );
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      String data = "";
      // print(response);
      if (response.statusCode == 200) {
        data = await response.stream.bytesToString();
        var dataMap = json.decode(data);
        // print(dataMap);
        await _peerConnection!.setRemoteDescription(
          RTCSessionDescription(
            dataMap["sdp"],
            dataMap["type"],
          ),
        );

      } else {
        print(response.reasonPhrase);
      }
    });
  }

  void _onDataChannelMessage(RTCDataChannelMessage message) {

    if(message.text != "" && message.text != _prevPrediction) {
      _prevPrediction = message.text;
      setState(() {
        _prediction += message.text +' ';
      });
    }
  }

  Future<void> _makeCall() async {

    _prevPrediction = "";
    setState(() {
      _prediction = "";
      _loading = true;

    });
    var configuration = <String, dynamic>{
      'sdpSemantics': 'unified-plan',
    };

    //* Create Peer Connection
    if (_peerConnection != null) return;
    _peerConnection = await createPeerConnection(
      configuration,
    );

    // _peerConnection!.onTrack = _onTrack;
    // _peerConnection!.onAddTrack = _onAddTrack;

    //* Create Data Channel
    _dataChannelDict = RTCDataChannelInit();
    _dataChannelDict!.ordered = true;
    _dataChannel = await _peerConnection!.createDataChannel(
      "chat",
      _dataChannelDict!,
    );
    _dataChannel!.onDataChannelState = _onDataChannelState;
    _dataChannel!.onMessage = _onDataChannelMessage;


    final mediaConstraints = <String, dynamic>{
      'audio': false,
      'video': {
        'mandatory': {
          'minWidth':
          '500', // Provide your own width, height and frame rate here
          'minHeight': '500',
          'minFrameRate': '14',
        },
        'facingMode': 'user',
        // 'facingMode': 'environment',
        'optional': [],
      }
    };

    try {
      var stream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
      // _mediaDevicesList = await navigator.mediaDevices.enumerateDevices();
      // _localStream = stream;
      // _localRenderer.srcObject = _localStream;
      setState(() {
        _localRenderer.srcObject = stream;
      });
      stream.getTracks().forEach((element) {
        _peerConnection!.addTrack(element, stream);
      });

      print("NEGOTIATE");
      await _negotiateRemoteConnection();
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) return;

    setState(() {
      _inCalling = true;
      _loading = false;
    });
  }

  Future<void> _stopCall() async {
    try {
      // await _localStream?.dispose();
      _prevPrediction = "";
      setState(() {
        _prediction = "";
      });

      await _dataChannel?.close();
      await _peerConnection?.close();
      _peerConnection = null;
      _localRenderer.srcObject = null;
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      _inCalling = false;
    });
  }

  Future<void> initLocalRenderers() async {
    await _localRenderer.initialize();
  }

  @override
  void initState() {
    super.initState();

    initLocalRenderers();
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
                    'Gesture Recognition Screen',
                    style: TextStyle(
                      color: const Color.fromRGBO(152,94,211, 1.0), // Set the color of the text to white
                      fontSize: 18.0 * MediaQuery.of(context).textScaleFactor, // Dynamic font size
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

      body: OrientationBuilder(
        builder: (context, orientation) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ConstrainedBox(
                      // height: MediaQuery.of(context).size.width > 500
                      //     ? 500
                      //     : MediaQuery.of(context).size.width - 20,
                      constraints: BoxConstraints(maxHeight: 500),
                      // width: MediaQuery.of(context).size.width > 500
                      //     ? 500
                      //     : MediaQuery.of(context).size.width - 20,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                color: Colors.black,
                                child: _loading
                                    ? Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 4,
                                  ),
                                )
                                    : Container(),
                              ),
                            ),
                            Positioned.fill(
                              child: RTCVideoView(
                                _localRenderer,
                                mirror: true,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          'Prediction: $_prediction',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: _loading
                        ? () {}
                        : _inCalling
                        ? _stopCall
                        : _makeCall,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _loading
                            ? Colors.amber
                            : _inCalling
                            ? Colors.red
                            : Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: _loading
                            ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )
                            : Text(
                          _inCalling ? "STOP" : "START",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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

    );
  }
}