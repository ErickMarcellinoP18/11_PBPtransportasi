import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  Future<void>? _initializeCameraFuture;
  late CameraController _cameraController;
  var count = 0;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _cameraController = CameraController(firstCamera, ResolutionPreset.medium);
    _initializeCameraFuture = _cameraController.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_initializeCameraFuture == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile Picture using Camera'),
      ),
      body: FutureBuilder<void>(
        future: _initializeCameraFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraController);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: const Icon(Icons.camera),
      ),
    );
  }

  // Future<DisplayPictureScreen?> previewImageResult() async {
  //   String activity = "Preview IMAGE RESULT";
  //   LoggingUtils.logStartFunction(activity);
  //   try {
  //     await _initializeCameraFuture;
  //     final image = await _cameraController.takePicture();
  //     if (!mounted) return null;
  //     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
  //       _cameraController.pausePreview();
  //       LoggingUtils.logDebugValue(
  //           "get image on previewImageResult".toUpperCase(),
  //           "image.path : ${image.path}");
  //       return DisplayPictureScreen(
  //           imagePath: image.path, cameraController: _cameraController);
  //     }));
  //   } catch (e) {
  //     LoggingUtils.logError(activity, e.toString());
  //     return null;
  //   }
  //   return null;
  // }
}
