import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:transportasi_11/component/passComp.dart';
import 'package:transportasi_11/data/client/userClient.dart';
import 'package:transportasi_11/view/loginRegistResetPass/login.dart';
import 'package:transportasi_11/component/form_component.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:intl/intl.dart';
import 'package:transportasi_11/view/Ticket/TicketPage.dart';

class RegisterView extends StatefulWidget {
  const RegisterView(
      {super.key,
      required this.id,
      required this.name,
      required this.email,
      required this.fullName,
      required this.noTelp,
      required this.password});

  final String? name, email, fullName, noTelp, password;
  final int? id;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerNotelp = TextEditingController();
  TextEditingController controllerFullname = TextEditingController();
  bool isPasswordVisible = false;

  List<Map<String, dynamic>> employee = [];
  void refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void submission() async {
      final ByteData data1 = await rootBundle.load('assets/images/ekonomi.jpg');
      final Uint8List imageBytes = data1.buffer.asUint8List();
      User input = User(
        id: 0,
        name: controllerUsername.text,
        email: controllerEmail.text,
        fullName: controllerFullname.text,
        noTelp: controllerNotelp.text,
        profilePicture: imageBytes,
        password: controllerPassword.text,
      );
      try {
        await userClient.create(input);
        showSnackbar(context, "Berhasil Register", Colors.green);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginView()));
      } catch (err) {
        showSnackbar(context, err.toString(), Colors.red);
      }
    }

    if (widget.id != null) {
      controllerUsername.text = widget.name!;
      controllerEmail.text = widget.email!;
      controllerPassword.text = widget.password!;
      controllerNotelp.text = widget.noTelp!;
      controllerFullname.text = widget.fullName!;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/GambarKeretaApi.jpg"),
                  fit: BoxFit.cover)),
          child: Center(
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              margin: EdgeInsets.only(
                right: 20,
                left: 20,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Daftar Akun",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Noto Sans HK',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                            } else
                              // if (emailUnique(value)) {
                              //   return 'Email Sudah Terdaftar';
                              // }
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
                                color: isPasswordVisible
                                    ? Colors.grey
                                    : Colors.blue,
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
                            } else if (!RegExp(r'^[a-zA-Z ]+$')
                                .hasMatch(value)) {
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
                        SizedBox(
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (widget.id == null) {
                                    submission();
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   const SnackBar(
                                    //     content: Text('Register Sukses'),
                                    //   ),
                                    // );
                                  }
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 16.0),
                                child: Text("Register"),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 142, 205, 221))),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginView()));
                            },
                            child: const Text('Sudah punya akun ?')),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showSnackbar(BuildContext context, String msg, Color bg) {
    final Scaffold = ScaffoldMessenger.of(context);
    Scaffold.showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: bg,
      action: SnackBarAction(
        label: 'hide',
        onPressed: Scaffold.hideCurrentSnackBar,
      ),
    ));
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

  // Future<void> editUser(int id) async {
  //   await SQLHelper.editUser(
  //       id,
  //       controllerUsername.text,
  //       controllerEmail.text,
  //       controllerPassword.text,
  //       controllerNotelp.text,
  //       controllerFullname.text);
  // }

  String judul(int id) {
    if (id == null) {
      return "Silahkan Buat Akun";
    } else {
      return "Silahkan Edit Akun";
    }
  }
}
