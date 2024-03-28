// // import 'package:flutter/material.dart';
// // import 'package:camera/camera.dart';
// // import 'package:tflite_flutter/tflite_flutter.dart';
// // import 'package:login_app/screens/welcome.dart';
// // import 'package:login_app/main.dart';
// //
// // class GestureRecognitionScreen extends StatefulWidget {
// //
// //   GestureRecognitionScreen({Key? key}) : super(key: key);
// //
// //   static String id = 'gesture_recognition_screen';
// //
// //   @override
// //   _GestureRecognitionScreenState createState() =>
// //       _GestureRecognitionScreenState();
// // }
// //
// // class _GestureRecognitionScreenState extends State<GestureRecognitionScreen> {
// //   late List<CameraDescription> cameras;
// //   late CameraController controller;
// //   bool isCameraInitialized = false;
// //   late Interpreter interpreter;
// //   TensorImage inputImage;
// //   TensorBuffer outputBuffer;
// //   String gestureLabel = 'No Gesture Detected';
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     loadModel();
// //     setupCamera();
// //   }
// //
// //   @override
// //   void dispose() {
// //     controller?.dispose();
// //     interpreter?.close();
// //     super.dispose();
// //   }
// //
// //   void setupCamera() async {
// //     try {
// //       cameras = await availableCameras();
// //       controller = CameraController(cameras[0], ResolutionPreset.medium);
// //       await controller.initialize();
// //       setState(() {
// //         isCameraInitialized = true;
// //       });
// //       controller.startImageStream((CameraImage image) {
// //         if (isCameraInitialized) {
// //           runGestureRecognition(image);
// //         }
// //       });
// //     } on CameraException catch (e) {
// //       print("Error: ${e.code}\nError Message: ${e.description}");
// //     }
// //   }
// //
// //   void loadModel() async {
// //     final interpreter = await tfl.Interpreter.fromAsset('assets/your_model.tflite');
// //     interpreter = await Interpreter.fromAsset('assets/your_model.tflite');
// //     inputImage = TensorImage.fromBuffer(inputImage);
// //     outputBuffer = TensorBuffer.createFixedSize(<int>[1, 29]);
// //   }
// //
// //   void runGestureRecognition(CameraImage image) async {
// //     inputImage.loadImage(image);
// //     inputImage.reshape([1, 224, 224, 3]);
// //
// //     interpreter.run(inputImage.buffer, outputBuffer.buffer);
// //
// //     final output = outputBuffer.getDoubleList();
// //     // Use output to determine the recognized gesture.
// //
// //     setState(() {
// //       // Update the gestureLabel based on the recognition results.
// //       gestureLabel = 'Detected Gesture: Your Gesture Label';
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     if (!isCameraInitialized) {
// //       return Scaffold(
// //         body: Center(
// //           child: CircularProgressIndicator(),
// //         ),
// //       );
// //     }
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Gesture Recognition'),
// //       ),
// //       body: Stack(
// //         children: [
// //           CameraPreview(controller),
// //           Align(
// //             alignment: Alignment.bottomCenter,
// //             child: Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: Text(
// //                 gestureLabel,
// //                 style: TextStyle(
// //                   fontSize: 24,
// //                   color: Colors.white,
// //                   backgroundColor: Colors.black,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// import 'dart:async';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'dart:io';
// import 'dart:convert';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
// import 'package:image/image.dart' as img;
//
// class _GestureRecognitionScreenState extends State<GestureRecognitionScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   late tfl.Interpreter _interpreter;
//   late List<String> _labels;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = CameraController(
//       widget.camera,
//       ResolutionPreset.medium,
//     );
//
//     _initializeControllerFuture = _controller.initialize();
//
//     // Load the TensorFlow Lite model and labels.
//     loadModel();
//     loadLabels();
//   }
//
//   Future<void> loadModel() async {
//     try {
//       final modelFile = 'assets/new_model.tflite';
//       _interpreter = await tfl.Interpreter.fromAsset(modelFile);
//       print("Model loaded successfully");
//     } catch (e) {
//       print("Error loading model: $e");
//     }
//   }
//
//   Future<void> loadLabels() async {
//     try {
//       final labelData = await rootBundle.loadString('assets/labels.txt');
//       _labels = LineSplitter.split(labelData).toList();
//     } catch (e) {
//       print("Error loading labels: $e");
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Gesture Recognition')),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return CameraPreview(_controller);
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           try {
//             await _initializeControllerFuture;
//             final image = await _controller.takePicture();
//             await detectGesture(image.path);
//           } catch (e) {
//             print(e);
//           }
//         },
//         child: const Icon(Icons.camera_alt),
//       ),
//     );
//   }
//
//   Future<void> detectGesture(String imagePath) async {
//     try {
//       final image = img.decodeImage(File(imagePath).readAsBytesSync())!;
//       final resizedImage = img.copyResize(image, width: 224, height: 224);
//       final preprocessedImage = resizedImage.getBytes();
//
//       final input =
//       tfl.Tensor.fromList(tfl.TfLiteType.float32, preprocessedImage);
//
//       _interpreter.allocateTensors();
//       _interpreter.getInputTensor(0)!.copyFrom(input.buffer.asUint8List());
//
//       _interpreter.invoke();
//       var output = _interpreter.getOutputTensor(0)!.data;
//
//       var prediction = output.buffer.asFloat32List();
//       var maxIndex = prediction.indexOf(
//           prediction.reduce((curr, next) => curr > next ? curr : next));
//
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Gesture Prediction'),
//           content: Text('Predicted gesture: ${_labels[maxIndex]}'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     } catch (e) {
//       print("Error detecting gesture: $e");
//     }
//   }
// }