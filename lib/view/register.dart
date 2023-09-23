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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> FormData = {};
                      FormData['username'] = usernameController.text;
                      FormData['password'] = passwordController.text;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => LoginView(
                                    data: FormData,
                                  )));
                    }
                  },
                  child: const Text('Register'))
            ],
          ),
        ),
      ),
    );
  }
}
