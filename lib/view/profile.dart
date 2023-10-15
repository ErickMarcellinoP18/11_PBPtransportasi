// import 'package:flutter/material.dart';
// import 'package:transportasi_11/database/sql_helper.dart';
// import 'package:transportasi_11/data/user.dart';

// class ProfileView extends StatefulWidget {
//   const ProfileView({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _ProfileViewState createState() => _ProfileViewState();
// }

// class _ProfileViewState extends State<ProfileView> {
//   Map<String, dynamic> _userData = {};

//   @override
//   void initState() {
//     _fetchUserData();
//     super.initState();
//   }

//   Future<void> _fetchUserData() async {
//     final userData = await SQLHelper.getUser();
//     if (userData.isNotEmpty) {
//       setState(() {
//         _userData = userData[];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profil Pengguna'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: CircleAvatar(
//                 radius: 50,
//                 // backgroundImage: AssetImage('assets/avatar.png'),
//               ),
//             ),
//             SizedBox(height: 16),
//             ProfileInfo(title: 'Username', info: _userData['name']),
//             ProfileInfo(title: 'Email', info: _userData['email']),
//             ProfileInfo(title: 'Nama Lengkap', info: _userData['fullName']),
//             ProfileInfo(title: 'Nomor Telepon', info: _userData['noTelp']),
//             ProfileInfo(title: 'Password', info: _userData['password']),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text('Cancel'),
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.red,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Tambahkan fungsionalitas simpan di sini
//                     },
//                     child: Text('Save'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ProfileInfo extends StatelessWidget {
//   final String title;
//   final String? info;

//   ProfileInfo({required this.title, this.info});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//         ListTile(
//           title: Text(info ?? 'Belum Diisi'),
//           leading: Icon(Icons.person),
//         ),
//         Divider(),
//       ],
//     );
//   }
// }
