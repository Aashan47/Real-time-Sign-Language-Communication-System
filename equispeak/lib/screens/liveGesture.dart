/*

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class GestureRecognitionScreen extends StatefulWidget {
  @override
  _GestureRecognitionScreenState createState() =>
      _GestureRecognitionScreenState();
}

class _GestureRecognitionScreenState extends State<GestureRecognitionScreen> {
  List<CameraDescription> cameras;
  CameraController controller;
  bool isCameraInitialized = false;
  Interpreter interpreter;
  TensorImage inputImage;
  TensorBuffer outputBuffer;
  String gestureLabel = 'No Gesture Detected';

  @override
  void initState() {
    super.initState();
    loadModel();
    setupCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    interpreter?.close();
    super.dispose();
  }

  void setupCamera() async {
    try {
      cameras = await availableCameras();
      controller = CameraController(cameras[0], ResolutionPreset.medium);
      await controller.initialize();
      setState(() {
        isCameraInitialized = true;
      });
      controller.startImageStream((CameraImage image) {
        if (isCameraInitialized) {
          runGestureRecognition(image);
        }
      });
    } on CameraException catch (e) {
      print("Error: ${e.code}\nError Message: ${e.description}");
    }
  }

  void loadModel() async {
    interpreter = await Interpreter.fromAsset('assets/your_model.tflite');
    inputImage = TensorImage.fromBuffer(inputImage);
    outputBuffer = TensorBuffer.createFixedSize(<int>[1, 29]);
  }

  void runGestureRecognition(CameraImage image) async {
    inputImage.loadImage(image);
    inputImage.reshape([1, 224, 224, 3]);

    interpreter.run(inputImage.buffer, outputBuffer.buffer);

    final output = outputBuffer.getDoubleList();
    // Use output to determine the recognized gesture.

    setState(() {
      // Update the gestureLabel based on the recognition results.
      gestureLabel = 'Detected Gesture: Your Gesture Label';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isCameraInitialized) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture Recognition'),
      ),
      body: Stack(
        children: [
          CameraPreview(controller),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                gestureLabel,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  backgroundColor: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/