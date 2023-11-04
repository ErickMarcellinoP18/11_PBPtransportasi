import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transportasi_11/data/user.dart';
import 'dart:io';

import 'package:transportasi_11/database/sql_helper.dart';
import 'package:transportasi_11/view/home.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final CameraController cameraController;
  final User loggedIn;

  const DisplayPictureScreen(
      {Key? key,
      required this.imagePath,
      required this.cameraController,
      required this.loggedIn});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  File? fileResult;

  @override
  void initState() {
    fileResult = File(widget.imagePath);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display The Picture'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          widget.cameraController.resumePreview();
          return true;
        },
        child: Column(
          children: [
            Image.file(fileResult!),
            const SizedBox(height: 48, width: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Berhasil Mengganti profile Picture'),
                        ),
                      );
                      await editProfilePicture(
                          widget.loggedIn.id!, fileResult!);
                      // await editUser(widget.id!);
                      widget.loggedIn.profilePicture =
                          await fileResult!.readAsBytes();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeView(loggedIn: widget.loggedIn)));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Save"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> editProfilePicture(int id, File image) async {
    final Uint8List imageBytes = await image.readAsBytes();
    await SQLHelper.editProfilePic(imageBytes, id);
  }
}
