import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
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

// ugd aapi
import 'package:transportasi_11/data/client/userClient.dart';

class ProfileView extends StatefulWidget {
  const ProfileView(
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
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerNotelp = TextEditingController();
  TextEditingController controllerFullname = TextEditingController();
  bool isPasswordVisible = false;

  List<Map<String, dynamic>> employee = [];
  void refresh() async {
    // final data = await SQLHelper.getUser();
    setState(() {
      // employee = data;
    });
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Silahkan Edit Akun"),
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
                // key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(widget.Profpicture.toString()),
                      SizedBox(height: 10),
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: MemoryImage(widget.Profpicture),
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
                      SizedBox(height: 24),
                      TextFormField(
                        controller: controllerUsername,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          } else if (value.contains(' ')) {
                            return 'Username tidak boleh ada spasi';
                          }
                          return null;
                        },
                      ),

                      // TextFormField(
                      //   controller: controllerUsername,
                      //   decoration: const InputDecoration(
                      //     border: UnderlineInputBorder(),
                      //     labelText: 'Username',
                      //   ),
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter your name';
                      //     } else if (value.contains(' ')) {
                      //       return 'Username tidak boleh ada spasi';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: controllerEmail,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email Tidak Boleh Kosong';
                          } else if (!value.contains('@')) {
                            return 'Email Tidak Valid';
                          } else if (emailUnique(value) && widget.id == null) {
                            return 'Email Sudah Terdaftar';
                          }
                          return null;
                        },
                      ),

                      // SizedBox(height: 24),
                      // TextFormField(
                      //   controller: controllerEmail,
                      //   decoration: const InputDecoration(
                      //     border: UnderlineInputBorder(),
                      //     labelText: 'Email',
                      //   ),
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Email Tidak Boleh Kosong';
                      //     } else if (!value.contains('@')) {
                      //       return 'Email Tidak Valid';
                      //     } else if (emailUnique(value) && widget.id == null) {
                      //       return 'Email Sudah Terdaftar';
                      //     }
                      //     return null;
                      //   },
                      // ),

                      SizedBox(height: 24),
                      TextFormField(
                        controller: controllerPassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color:
                                  isPasswordVisible ? Colors.grey : Colors.blue,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        obscureText: isPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password Tidak Boleh Kosong';
                          } else if (value.length < 8) {
                            return 'Password Minimal 8 karakter';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 24),
                      TextFormField(
                        controller: controllerFullname,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                            return 'Nama Lengkap hanya mengandung huruf dan spasi';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 24),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controllerNotelp,
                        decoration: InputDecoration(
                          labelText: 'Nomor Telepon',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nomor Telepon tidak boleh kosong';
                          } else if (value.length < 10 || value.length > 13) {
                            return 'Nomor Telepon Tidak Valid';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 48, width: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  User main = User(
                                      id: widget.id,
                                      fullName: controllerFullname.text,
                                      email: controllerEmail.text,
                                      noTelp: controllerNotelp.text,
                                      name: controllerUsername.text,
                                      password: controllerPassword.text,
                                      profilePicture: widget.Profpicture);

                                  await editUser(widget.id!, main);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomeView(loggedIn: main)));
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Update"),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Exit'),
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
          Navigator.pushReplacement(
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
  // String judul(int id) {
  //   if (id == null) {
  //     return "Silahkan Buat Akun";
  //   } else {
  //     return "Silahkan Edit Akun";
  //   }
  // }
}
