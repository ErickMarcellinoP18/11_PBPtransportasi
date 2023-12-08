import 'package:flutter/material.dart';
import 'package:transportasi_11/data/client/userClient.dart';
import 'package:transportasi_11/view/loginRegistResetPass/login.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void gantiPassword() async {
    try {
      await userClient.ResetPass(
          _emailController.text, passwordController.text);
      showSnackbar(context, "Berhasil Mengganti Password", Colors.green);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginView()));
    } catch (e) {
      showSnackbar(context, "Gagal ganti password", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Masukan Username anda',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Username anda',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password baru',
                hintText: 'Password Baru',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                gantiPassword();
              },
              child: Text('Reset Password'),
            ),
          ],
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
}
