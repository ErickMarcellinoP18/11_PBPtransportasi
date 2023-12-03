import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:transportasi_11/component/passComp.dart';
import 'package:transportasi_11/data/client/userClient.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:transportasi_11/main.dart';
import 'package:transportasi_11/view/TicketPage.dart';
import 'package:transportasi_11/view/home.dart';
import 'package:transportasi_11/view/homePetugas.dart';
import 'package:transportasi_11/view/register.dart';
import 'package:transportasi_11/database/sql_helper.dart';
import 'package:transportasi_11/component/form_component.dart';
import 'package:transportasi_11/view/resetPass.dart';

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
        showSnackbar(context, "Gagal Login", Colors.red);
        return null;
      }
    }

    Map? dataForm = widget.data;
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
                top: 200,
                bottom: 200,
                right: 40,
                left: 40,
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Noto Sans HK',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
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
                      SizedBox(height: 24),
                      TextFormField(
                        controller: controllerPassword,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
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
                              color:
                                  isPasswordVisible ? Colors.grey : Colors.blue,
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
                          Expanded(
                            child: ElevatedButton(
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
                                        builder: (context) =>
                                            const HomePagePetugas(),
                                      ),
                                    );
                                  } else {
                                    User? loggedIn = await login(
                                        controllerUsername.text,
                                        controllerPassword.text);
                                    if (loggedIn != null) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomeView(
                                                  loggedIn: loggedIn)));
                                    }
                                  }
                                }
                              },
                              child: const Text('Login'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 142, 205, 221)),
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ForgetPasswordPage(),
                                      ));
                                },
                                child: const Text('Lupa Password?',
                                    style: TextStyle(color: Colors.redAccent))),
                            TextButton(
                                onPressed: () {
                                  Map<String, dynamic> formData = {};
                                  formData['username'] =
                                      controllerUsername.text;
                                  formData['password'] =
                                      controllerPassword.text;
                                  pushRegister(context);
                                },
                                child: const Text(
                                  'Belum Punya Akun?',
                                )),
                          ],
                        ),
                      ),
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
