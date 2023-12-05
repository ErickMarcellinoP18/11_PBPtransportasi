import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:transportasi_11/component/passComp.dart';
import 'package:transportasi_11/data/client/userClient.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:transportasi_11/main.dart';
import 'package:transportasi_11/view/Ticket/TicketPage.dart';
import 'package:transportasi_11/view/home.dart';
import 'package:transportasi_11/view/PetugasView/homePetugas.dart';
import 'package:transportasi_11/view/loginRegistResetPass/register.dart';
import 'package:transportasi_11/database/sql_helper.dart';
import 'package:transportasi_11/component/form_component.dart';
import 'package:transportasi_11/view/loginRegistResetPass/resetPass.dart';

class LoginView extends StatefulWidget {
  final Map? data;
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  bool isPasswordVisible = true;

  // List<Map<String, dynamic>> employee = [];
  // void refresh() async {
  //   final data = await SQLHelper.getUser();
  //   setState(() {
  //     employee = data;
  //   });
  // }

  // @override
  // void initState() {
  //   refresh();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Future<User?> login(String username, String password) async {
      try {
        User loggedIn = await userClient.Login(username, password);
        showSnackbar(context, "Berhasil Login", Colors.green);
        return loggedIn;
      } catch (e) {
        print(e);
        showSnackbar(context, "Gagal Login", Colors.red);
        return null;
      }
    }

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
                  key: const Key('username'),
                  controller: controllerUsername,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    } else if (value.contains(' ')) {
                      return 'Username tidak boleh ada spasi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: controllerPassword,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      key: const Key('password'),
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
                      key: const Key('LoginBtn'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (controllerUsername.text == 'Petugas' &&
                              controllerPassword.text == 'petugasPBP') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login Petugas'),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePagePetugas(),
                              ),
                            );
                          } else {
                            User? loggedIn = await login(
                                controllerUsername.text,
                                controllerPassword.text);
                            if (loggedIn != null) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomeView(loggedIn: loggedIn)));
                            }
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
                        child: const Text('Belum Punya Akun?')),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgetPasswordPage(),
                              ));
                        },
                        child: const Text('Lupa Password?'))
                  ],
                )
              ],
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

  // int findUser(String nama, String password) {
  //   for (int i = 0; i < employee.length; i++) {
  //     if (employee[i]['name'] == nama && employee[i]['password'] == password) {
  //       return i;
  //     }
  //     print(nama);
  //     print(employee[i]['name'] + 'employee');
  //     print(password);
  //     print(employee[i]['password'] + 'employee');
  //   }
  //   return -1;
  // }
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
