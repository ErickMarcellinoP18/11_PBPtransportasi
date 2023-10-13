import 'package:flutter/material.dart';
import 'package:transportasi_11/component/passComp.dart';
import 'package:transportasi_11/view/home.dart';
import 'package:transportasi_11/view/register.dart';
import 'package:transportasi_11/component/form_component.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  final Map? data;
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              inputForm((p0) {
                if (p0 == null || p0.isEmpty) {
                  return "Username tidak boleh kosong";
                }
                return null;
              },
                  controller: usernameController,
                  hintTxt: "Username",
                  helperTxt: "Inputkan user yang telah didaftar",
                  iconData: Icons.person),
              PassForm(passwordController: passwordController),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (dataForm!['username'] == usernameController.text &&
                            dataForm!['password'] == passwordController.text) {
                          // Simpan data pengguna ke shared_preferences
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString('username', usernameController.text);

                          // Navigasi ke halaman yang sesuai (misalnya, HomeView atau ProfileView)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeView(),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Password Salah'),
                              content: TextButton(
                                onPressed: () => pushRegister(context),
                                child: const Text('Daftar Disini'),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: () {
                      Map<String, dynamic> formData = {};
                      formData['username'] = usernameController.text;
                      formData['password'] = passwordController.text;
                      pushRegister(context);
                    },
                    child: const Text('Belum punya akun ?'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

void pushRegister(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const RegisterView(
        id: null,
        name: '',
        email: '',
        fullName: '',
        noTelp: '',
        password: '',
      ),
    ),
  );
}
