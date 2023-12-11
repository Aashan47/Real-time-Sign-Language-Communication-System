import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CameraPage extends StatefulWidget {
  @override
  static String id = 'gesture_screen';
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  Future<void>? _initializeCameraFuture;
  IO.Socket? socket;
  Timer? _timer;
  String prediction = '';
  bool isCapturing = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeWebSocket();
  }

  void _initializeWebSocket() {
    socket = IO.io('https://01a2-39-60-195-190.ngrok-free.app', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();

    socket!.on('prediction', (data) {
      if (mounted) {
        setState(() {
          prediction = data['result'];
        });
      }
    });

    socket!.on('connect', (_) {
      print('connected to websocket');
      _startSendingFrames();
    });

    socket!.on('disconnect', (_) => print('disconnected from websocket'));

    // Handle other events and emit data as needed
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(firstCamera, ResolutionPreset.medium);
    _initializeCameraFuture = _cameraController!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cameraController?.dispose();
    socket?.disconnect();
    super.dispose();
  }

  void _startSendingFrames() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) async {
      if (!mounted) return;
      if (!_cameraController!.value.isInitialized || isCapturing) {
        return;
      }

      try {
        isCapturing = true;
        XFile file = await _cameraController!.takePicture();
        Uint8List bytes = await file.readAsBytes();
        String base64Image = base64Encode(bytes);

        // Send this base64Image string to your backend
        socket?.emit('frame', base64Image);
      } catch (e) {
        // Handle any errors here
      } finally {
        isCapturing = false;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(7.5), // Add padding here
            child: Container(
              width: double.infinity,
              height: 500,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              child: FutureBuilder<void>(
                future: _initializeCameraFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15), // Clip the CameraPreview with rounded corners
                      child: CameraPreview(_cameraController!),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Prediction: $prediction',
            style: const TextStyle(
              fontSize: 24, // Increase font size
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
