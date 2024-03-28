import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:login_app/screens/welcome.dart';
import 'package:login_app/main.dart';

class BlankScreen extends StatefulWidget {
  BlankScreen({Key? key}) : super(key: key);

  static String id = 'blank_screen';

  @override
  _BlankScreenState createState() => _BlankScreenState();
}

class _BlankScreenState extends State<BlankScreen> {
  TextEditingController _textEditingController = TextEditingController();
  List<String> chatMessages = [];
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    // Initialize camera controller
    _initializeCamera();

  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Your existing code...

        child: Center(
          child: Column(
            // Your existing code...

            children: <Widget>[
              Row(
                children: <Widget>[
                  // Your existing code...

                  ElevatedButton(
                    onPressed: () {
                      _openCamera();
                    },
                    child: Text('Open Camera'),
                  ),
                ],
              ),

              // Your existing code...
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openCamera() async {
    try {
      await _initializeControllerFuture;

      // Open the camera
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraPreview(_cameraController),
        ),
      );
    } catch (e) {
      print("Error opening camera: $e");
    }
  }
}


// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:tflite/tflite.dart';
//
// class BlankScreen extends StatefulWidget {
//   BlankScreen({Key? key}) : super(key: key);
//
//   static String id = 'blank_screen';
//
//   @override
//   _BlankScreenState createState() => _BlankScreenState();
// }
//
// class _BlankScreenState extends State<BlankScreen> {
//   late CameraController _cameraController;
//   late Future<void> _initializeControllerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//     _loadModel();
//   }
//
//   Future<void> _loadModel() async {
//     try {
//       String modelPath = 'assets/new_model.tflite';
//       await Tflite.loadModel(
//         model: modelPath,
//         labels: 'assets/labels.txt',
//       );
//     } catch (e) {
//       print("Error loading TFLite model: $e");
//     }
//   }
//
//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     final firstCamera = cameras.first;
//
//     _cameraController = CameraController(
//       firstCamera,
//       ResolutionPreset.medium,
//     );
//
//     _initializeControllerFuture = _cameraController.initialize();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Center(
//           child: Column(
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   ElevatedButton(
//                     onPressed: () {
//                       _openCamera();
//                     },
//                     child: Text('Open Camera'),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: Container(
//                   child: CameraPreview(
//                     _cameraController,
//                     onCameraImage: (CameraImage image) {
//                       _processAndInferImage(image);
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _openCamera() async {
//     try {
//       await _initializeControllerFuture;
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CameraPreview(
//             _cameraController,
//             onCameraImage: (CameraImage image) {
//               _processAndInferImage(image);
//             },
//           ),
//         ),
//       );
//     } catch (e) {
//       print("Error opening camera: $e");
//     }
//   }
//
//   void _processAndInferImage(CameraImage image) async {
//     try {
//       // Preprocess the image if needed
//       var output = await Tflite.runModelOnFrame(
//         bytesList: image.planes.map((plane) {
//           return plane.bytes;
//         }).toList(),
//         imageHeight: image.height,
//         imageWidth: image.width,
//         imageMean: 0.0, // Adjust as needed
//         imageStd: 255.0, // Adjust as needed
//         rotation: 90, // Adjust as needed
//         numResults: 5, // Adjust as needed
//       );
//
//       // Display results or take any action based on the output
//       print("Model output: $output");
//     } catch (e) {
//       print("Error running inference: $e");
//     }
//   }
//
//   @override
//   void dispose() {
//     _cameraController.dispose();
//     Tflite.close();
//     super.dispose();
//   }
// }
