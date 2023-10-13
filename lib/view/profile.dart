import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? username;
  String? email;
  String? fullName;
  String? noTelp;
  String? password;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      email = prefs.getString('email');
      fullName = prefs.getString('fullName');
      noTelp = prefs.getString('noTelp');
      password = prefs.getString('password');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pengguna'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
            ),
            SizedBox(height: 16),
            ProfileInfo(title: 'Username', info: '$username'),
            ProfileInfo(title: 'Email', info: '$email'),
            ProfileInfo(title: 'Nama Lengkap', info: '$fullName'),
            ProfileInfo(title: 'Nomor Telepon', info: '$noTelp'),
            ProfileInfo(title: 'Password', info: '$password'),
            SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ElevatedButton(onPressed: (){
                          Navigator.pushNamed(context, '/editprofile');
                        }, child: Text('Cancel'), style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ElevatedButton(onPressed: (){
                          Navigator.pushNamed(context, '/editprofile');
                        }, child: Text('Save')),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String title;
  final String? info;

  ProfileInfo({required this.title, this.info});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        ListTile(
          title: Text(info ?? 'Belum Diisi'),
          leading: Icon(Icons.person),
        ),
        Divider(),
      ],
    );
  }
}
