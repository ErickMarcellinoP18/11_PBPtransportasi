import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:transportasi_11/camera/camera.dart';
import 'package:transportasi_11/camera/imagepicker.dart';
import 'package:transportasi_11/component/passComp.dart';
import 'package:transportasi_11/main.dart';
import 'package:transportasi_11/view/home.dart';
import 'package:transportasi_11/view/loginRegistResetPass/login.dart';
import 'package:transportasi_11/component/form_component.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:intl/intl.dart';
import 'package:transportasi_11/view/Ticket/TicketPage.dart';
import 'package:transportasi_11/view/profile/profile.dart';
import 'package:transportasi_11/view/loginRegistResetPass/resetPass.dart';
import 'package:transportasi_11/data/client/userClient.dart';

class editProfile extends StatefulWidget {
  const editProfile(
      {super.key,
      required this.id,
      required this.name,
      required this.email,
      required this.fullName,
      required this.noTelp,
      required this.password,
      required this.Profpicture});

  final String? name, email, fullName, noTelp, password;
  final int? id;
  final Uint8List Profpicture;

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerNotelp = TextEditingController();
  TextEditingController controllerFullname = TextEditingController();
  bool isPasswordVisible = false;

  List<Map<String, dynamic>> employee = [];
  void refresh() async {
    LoggedIn();
    setState(() {});
  }

  void LoggedIn() async {
    try {
      User loggedIn = await userClient.find(widget.id);
      controllerEmail.value = TextEditingValue(text: loggedIn.email.toString());
      controllerFullname.value =
          TextEditingValue(text: loggedIn.fullName.toString());
      controllerNotelp.value =
          TextEditingValue(text: loggedIn.noTelp.toString());
      controllerPassword.value =
          TextEditingValue(text: loggedIn.password.toString());
      controllerUsername.value =
          TextEditingValue(text: loggedIn.name.toString());
      // tempProfPict = loggedIn.profilePicture!;
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    refresh();
    super.initState();
    LoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    refresh();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Profil"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  right: 40,
                  left: 40,
                ),
                height: 690,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(2, 2),
                        blurRadius: 5)
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(widget.Profpicture.toString())
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: MemoryImage(widget.Profpicture),
                              // backgroundImage: MemoryImage(
                              //     widget.Profpicture ?? Uint8List(0)),
                            ),
                            Positioned(
                                bottom: -10,
                                right: -15,
                                child: IconButton(
                                    onPressed: () {
                                      OptionPopUp().then((_) => refresh());
                                    },
                                    icon: Icon(Icons.camera_alt)))
                          ],
                        ),
                      ),

                      SizedBox(height: 10),
                      Text(
                        widget.fullName.toString(),
                        style: TextStyle(fontSize: 30),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_box, color: Colors.blue),
                        title: Text(widget.name.toString()),
                      ),
                      ListTile(
                        leading:
                            Icon(Icons.alternate_email, color: Colors.blue),
                        title: Text(widget.email.toString()),
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileView(
                                          id: widget.id,
                                          fullName: controllerFullname.text,
                                          email: controllerEmail.text,
                                          noTelp: controllerNotelp.text,
                                          name: controllerUsername.text,
                                          password: controllerPassword.text,
                                          Profpicture: widget.Profpicture)));
                            },
                            style: OutlinedButton.styleFrom(
                              primary: Colors.blue,
                              side: BorderSide(color: Colors.blue),
                            ),
                            child: const Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.start, // Menggeser ke kiri
                              children: [
                                Icon(Icons.alternate_email, color: Colors.blue),
                                SizedBox(
                                    width:
                                        30), // Menambahkan jarak antara ikon dan teks
                                Text("Edit Akun"),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPasswordPage()));
                            },
                            style: OutlinedButton.styleFrom(
                              primary: Colors.blue,
                              side: BorderSide(color: Colors.blue),
                            ),
                            child: const Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.start, // Menggeser ke kiri
                              children: [
                                Icon(Icons.alternate_email, color: Colors.blue),
                                SizedBox(
                                    width:
                                        30), // Menambahkan jarak antara ikon dan teks
                                Text("Ganti Password"),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 48, width: 100),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> addUser() async {
  //   await SQLHelper.addUser(
  //       controllerUsername.text,
  //       controllerEmail.text,
  //       controllerPassword.text,
  //       controllerNotelp.text,
  //       controllerFullname.text);
  // }

  bool emailUnique(String email) {
    for (int i = 0; i < employee.length; i++) {
      if (employee[i]['email'] == email) {
        return true;
      }
    }
    return false;
  }

  Future<void> editUser(int id, User user) async {
    try {
      // Panggil fungsi update dari userClient
      await userClient.update(user);
    } catch (e) {
      print("Error during user update: $e");
    }
  }

  // Future<void> editProfilePicture(int id, File image) async {
  //   final Uint8List imageBytes = await image.readAsBytes();
  //   await SQLHelper.editProfilePic(imageBytes, id);
  // }

  Future OptionPopUp() async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_rounded),
                title: Text("Take Photo From Camera"),
                onTap: () {
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.browse_gallery),
                title: Text("Open Photo From Gallery"),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                },
              )
            ],
          );
        });
  }

  Future _pickImage(ImageSource sources) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: sources);
      setState(() {
        if (pickedImage != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ImagePickerButton(
                        loggedin: User(
                            id: widget.id,
                            email: widget.email,
                            fullName: widget.fullName,
                            name: widget.name,
                            noTelp: widget.noTelp,
                            password: widget.password,
                            profilePicture: widget.Profpicture),
                        imageUpdate: pickedImage,
                      )));
        }
      });
    } catch (e) {
      print("Error when picking image");
    }
  }
}
