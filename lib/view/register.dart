import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:transportasi_11/component/passComp.dart';
import 'package:transportasi_11/view/login.dart';
import 'package:transportasi_11/component/form_component.dart';
import 'package:intl/intl.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

//deklarasi list untuk gender
enum listGender { laki_laki, perempuan }

class _RegisterViewState extends State<RegisterView> {
  TextEditingController dateinput = TextEditingController();
  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  //Checkbox
  bool ketentuan = false;
  //radio
  listGender? _gender;

  void _showAlertDialog(
      String title, String message, Map<String, dynamic> FormData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) =>
                        LoginView(data: FormData))); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: Color.fromARGB(255, 101, 92, 218),
              width: 1.0,
            ),
          ),
        );
      },
    );
  }

  void _showAlertDialog2(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => RegisterView())); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: Color.fromARGB(255, 101, 92, 218),
              width: 1.0,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                inputForm((p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Username Tidak Boleh Kosong';
                  }
                  if (p0.toLowerCase() == 'anjing') {
                    return 'Tidak Boleh Menggunakan kata Kasar';
                  }
                  return null;
                },
                    controller: usernameController,
                    hintTxt: "Username",
                    helperTxt: "Ucup Surucup",
                    iconData: Icons.person),
                inputForm((p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                },
                    controller: emailController,
                    hintTxt: "Email",
                    helperTxt: "ucup@gmail.com",
                    iconData: Icons.email),
                PassForm(passwordController: passwordController),
                inputForm((p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Nomor Telepon tidak boleh kosong';
                  }
                  return null;
                },
                    controller: notelpController,
                    hintTxt: "No Telp",
                    helperTxt: "0821123456789",
                    iconData: Icons.phone_android),
                //radio button
                Padding(
                  padding: const EdgeInsets.only(left: 60, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gender :'),
                      RadioListTile(
                        title: Text('laki laki'),
                        value: listGender.laki_laki,
                        groupValue: _gender,
                        onChanged: (val) {
                          setState(() {
                            _gender = val;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('Perempuan'),
                        value: listGender.perempuan,
                        groupValue: _gender,
                        onChanged: (val) {
                          setState(() {
                            _gender = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      controller: dateinput,
                      decoration: InputDecoration(
                        labelText: "Enter Date",
                        contentPadding: EdgeInsets.all(10.0),
                        filled: true,
                        icon: Icon(Icons.calendar_today),
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black45),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2100));

                        if (date != null) {
                          print(date);
                          String formatDate =
                              DateFormat('dd/MM/yyyy').format(date);
                          print(formatDate);
                          setState(() {
                            dateinput.text = formatDate;
                          });
                        }
                      },
                    ),
                  ),
                ),
                //Checkbox-----
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 20),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: Text(
                            'Saya menyetujui syarat dan ketentuan yang berlaku'),
                        value: ketentuan,
                        onChanged: (value) {
                          setState(() {
                            ketentuan = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          ketentuan &&
                          !dateinput.text.isEmpty &&
                          _gender != null) {
                        bool registrationSuccessful = true;
                        Map<String, dynamic> FormData = {};
                        FormData['username'] = usernameController.text;
                        FormData['password'] = passwordController.text;
                        if (registrationSuccessful) {
                          // Show the success alert dialog
                          _showAlertDialog(
                              'Success', 'Registrasi berhasil!', FormData);
                          // You can navigate to another screen (e.g., login) here if needed.
                        }
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => LoginView(
                        //               data: FormData,
                        //             )));
                      }
                      // } else if (_gender == null) {
                      //   _showAlertDialog2('Failed', 'Pilih Gender dulu!');
                      // } else if (dateinput.text.isEmpty) {
                      //   _showAlertDialog2('Failed', 'Isi tanggal dulu!');
                      // } else if (!ketentuan) {
                      //   _showAlertDialog2('Failed', 'Cek dulu bang!');
                      // }
                    },
                    child: const Text('Register'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
