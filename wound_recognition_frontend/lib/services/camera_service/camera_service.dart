// import 'dart:async';
// import 'dart:typed_data';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'dart:math';
//
// class CameraBrightnessChecker extends StatefulWidget {
//   @override
//   _CameraBrightnessCheckerState createState() => _CameraBrightnessCheckerState();
// }
//
// class _CameraBrightnessCheckerState extends State<CameraBrightnessChecker> {
//   CameraController? _controller;
//   String _status = 'loading';
//
//   @override
//   void initState() {
//     super.initState();
//     _initCamera();
//   }
//
//   Future<void> _initCamera() async {
//     final cameras = await availableCameras();
//     _controller = CameraController(cameras[0], ResolutionPreset.low);
//     await _controller!.initialize();
//
//     // Start beeldanalyse
//     _controller!.startImageStream(_analyzeBrightness);
//
//     setState(() {});
//   }
//
//   void _analyzeBrightness(CameraImage image) {
//     // Alleen Y (luminantie) kanaal gebruiken voor helderheid
//     final bytes = image.planes[0].bytes;
//     final brightness = bytes.reduce((a, b) => a + b) / bytes.length;
//
//     if (brightness < 50) {
//       setState(() => _status = 'dark');
//     } else if (brightness < 100) {
//       setState(() => _status = 'dim');
//     } else {
//       setState(() => _status = 'ok');
//     }
//   }
//
//   Widget _buildStatusMessage() {
//     switch (_status) {
//       case 'dark':
//         return _message("Te donker. Zorg voor meer licht.", Colors.red);
//       case 'dim':
//         return _message("Licht is zwak. Verbeter indien mogelijk.", Colors.orange);
//       case 'ok':
//         return _message("Licht is goed!", Colors.green);
//       default:
//         return Text("Camera starten...");
//     }
//   }
//
//   Widget _message(String text, Color color) {
//     return Container(
//       margin: EdgeInsets.all(12),
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         border: Border.all(color: color),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.warning_amber_rounded, color: color),
//           SizedBox(width: 8),
//           Expanded(
//             child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Helderheidscontrole")),
//       body: _controller?.value.isInitialized == true
//           ? Column(
//         children: [
//           AspectRatio(
//             aspectRatio: _controller!.value.aspectRatio,
//             child: CameraPreview(_controller!),
//           ),
//           _buildStatusMessage(),
//         ],
//       )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }