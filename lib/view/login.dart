import 'package:flutter/material.dart';
import 'package:transportasi_11/component/passComp.dart';
import 'package:transportasi_11/view/home.dart';
import 'package:transportasi_11/view/register.dart';
import 'package:transportasi_11/database/sql_helper.dart';
import 'package:transportasi_11/component/form_component.dart';

class LoginView extends StatefulWidget {
  final Map? data;
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
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
    TextEditingController controllerUsername = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();
    bool isPasswordVisible = false;

    Map? dataForm = widget.data;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (findUser(controllerUsername.text,
                                  controllerPassword.text) ==
                              true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login Sukses'),
                              ),
                            );
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginView()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login Gagal'),
                              ),
                            );
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginView()));
                            // showDialog(
                            //     context: context,
                            //     builder: (_) => AlertDialog(
                            //           title: const Text('Password Salah'),
                            //           content: TextButton(
                            //               onPressed: () => pushRegister(context),
                            //               child: const Text('Daftar Disini')),
                            //           actions: <Widget>[
                            //             TextButton(
                            //               onPressed: () =>
                            //                   Navigator.pop(context, 'Cancel'),
                            //               child: const Text('Cancel'),
                            //             ),
                            //             TextButton(
                            //               onPressed: () =>
                            //                   Navigator.pop(context, 'OK'),
                            //               child: const Text('OK'),
                            //             ),
                            //           ],
                            //         ));
                          }
                        }
                      },
                      child: const Text('Login'),
                    ),
                    TextButton(
                        onPressed: () {
                          Map<String, dynamic> formData = {};
                          formData['username'] = controllerUsername.text;
                          formData['password'] = controllerPassword.text;
                          pushRegister(context);
                        },
                        child: const Text('Belum punya akun ?')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool findUser(String nama, String password) {
    for (int i = 0; i < employee.length; i++) {
      if (employee[i]['name'] == nama && employee[i]['password'] == password) {
        return true;
      }
    }
    return false;
  }
}

void pushRegister(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const RegisterView(
          id: null,
          name: null,
          email: null,
          fullName: null,
          noTelp: null,
          password: null),
    ),
  );
}
