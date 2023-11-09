import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:transportasi_11/database/sql_helper.dart';
import 'package:transportasi_11/view/home.dart';

class ImagePickerButton extends StatefulWidget {
  final User loggedin;
  final XFile imageUpdate;
  const ImagePickerButton(
      {super.key, required this.loggedin, required this.imageUpdate});

  @override
  State<ImagePickerButton> createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  List<Map<String, dynamic>> employee = [];
  void refresh() async {
    final data = await SQLHelper.getUser();
    setState(() {
      employee = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile Picture"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.file(File(widget.imageUpdate.path)),
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
                          widget.loggedin.id!, File(widget.imageUpdate.path));
                      // await editUser(widget.id!);
                      widget.loggedin.profilePicture =
                          await File(widget.imageUpdate.path).readAsBytes();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeView(loggedIn: widget.loggedin)));
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

  Future _pickImage() async {
    try {
      final XFile? pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedImage != null) {
          editProfilePicture(widget.loggedin.id!, File(pickedImage.path));
          widget.loggedin.profilePicture =
              File(pickedImage.path).readAsBytes() as Uint8List?;
        }
      });
    } catch (e) {
      print("Error when picking image");
    }
  }
}
