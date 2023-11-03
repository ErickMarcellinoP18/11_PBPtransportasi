import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:transportasi_11/component/passComp.dart';
import 'package:transportasi_11/main.dart';
import 'package:transportasi_11/view/home.dart';
import 'package:transportasi_11/view/login.dart';
import 'package:transportasi_11/component/form_component.dart';
import 'package:transportasi_11/database/sql_helper.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:intl/intl.dart';
import 'package:transportasi_11/view/TicketPage.dart';

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
    final data = await SQLHelper.getUser();
    setState(() {
      employee = data;
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      controllerUsername.text = widget.name!;
      controllerEmail.text = widget.email!;
      controllerPassword.text = widget.password!;
      controllerNotelp.text = widget.noTelp!;
      controllerFullname.text = widget.fullName!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Silahkan Edit Akun"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(widget.Profpicture.toString()),
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
                                onPressed: null, icon: Icon(Icons.camera_alt)))
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: controllerUsername,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Username',
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
                  SizedBox(height: 24),
                  TextFormField(
                    controller: controllerEmail,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Email',
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
                  SizedBox(height: 24),
                  TextFormField(
                    controller: controllerPassword,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
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
                          color: isPasswordVisible ? Colors.grey : Colors.blue,
                        ),
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
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Full Name',
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
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Nomor Telepon',
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
                              if (widget.id == null) {
                                await addUser();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Register Sukses'),
                                  ),
                                );
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginView()));
                              } else {
                                User main = User(
                                    id: widget.id,
                                    fullName: controllerFullname.text,
                                    email: controllerEmail.text,
                                    noTelp: controllerNotelp.text,
                                    name: controllerUsername.text,
                                    password: controllerPassword.text,
                                    profilePicture: widget.Profpicture);

                                await editUser(widget.id!);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomeView(loggedIn: main)));
                              }
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Register"),
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
          ),
        ),
      ),
    );
  }

  Future<void> addUser() async {
    await SQLHelper.addUser(
        controllerUsername.text,
        controllerEmail.text,
        controllerPassword.text,
        controllerNotelp.text,
        controllerFullname.text);
  }

  bool emailUnique(String email) {
    for (int i = 0; i < employee.length; i++) {
      if (employee[i]['email'] == email) {
        return true;
      }
    }
    return false;
  }

  Future<void> editUser(int id) async {
    await SQLHelper.editUser(
        id,
        controllerUsername.text,
        controllerEmail.text,
        controllerPassword.text,
        controllerNotelp.text,
        controllerFullname.text);
  }

  // String judul(int id) {
  //   if (id == null) {
  //     return "Silahkan Buat Akun";
  //   } else {
  //     return "Silahkan Edit Akun";
  //   }
  // }
}

// class ProfileInfo extends StatelessWidget {
//   final String title;
//   final String? info;

//   ProfileInfo({required this.title, this.info});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//         ListTile(
//           title: Text(info ?? 'Belum Diisi'),
//           leading: Icon(Icons.person),
//         ),
//         Divider(),
//       ],
//     );
//   }
// }
