import 'package:flutter/material.dart';
import 'package:transportasi_11/database/sql_helper.dart';
import 'package:transportasi_11/data/user.dart';

class Profil extends StatefulWidget {
  // final Map? data;
  // final User loggedIn;

  final String? name, email, fullName, noTelp, password;
  final int? id;
  const Profil(
      {super.key,
      required this.id,
      required this.name,
      required this.email,
      required this.fullName,
      required this.noTelp,
      required this.password});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  //mangambil data
  // final _formKey = GlobalKey<FormState>();

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerNotelp = TextEditingController();
  TextEditingController controllerFullname = TextEditingController();
  bool isPasswordVisible = false;

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
    if (widget.id != null) {
      controllerUsername.text = widget.name!;
      controllerEmail.text = widget.email!;
      controllerPassword.text = widget.password!;
      controllerNotelp.text = widget.noTelp!;
      controllerFullname.text = widget.fullName!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pengguna'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    isPasswordVisible ? Icons.visibility_off : Icons.visibility,
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
          ],
        ),
      ),
    );
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
}
