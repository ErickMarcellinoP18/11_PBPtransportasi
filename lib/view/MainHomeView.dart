import 'package:flutter/material.dart';
import 'package:transportasi_11/data/ticket.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:transportasi_11/database/sql_helper.dart';
import 'package:transportasi_11/view/register.dart';
import 'package:transportasi_11/view/ticketInputPage.dart';
import 'package:transportasi_11/view/profile.dart';
import 'package:transportasi_11/view/profileCoba.dart';

class TicketHomePage extends StatefulWidget {
  const TicketHomePage({super.key, required this.loggedIn});
  final User loggedIn;
  @override
  State<TicketHomePage> createState() => _TicketHomePageState();
}

class _TicketHomePageState extends State<TicketHomePage> {
  List<Map<String, dynamic>> ticket = [];
  List<Map<String, dynamic>> user = [];
  void refresh() async {
    final data = await SQLHelper.getTicket();
    final dataUser = await SQLHelper.getUser();
    setState(() {
      ticket = data;
      user = dataUser;
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello," + widget.loggedIn.name!),
        actions: [
          IconButton(
            icon: Icon(Icons.person_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (_) => const ProfileView()
                  builder: (_) => RegisterView(
                    id: widget.loggedIn.id!,
                    name: widget.loggedIn.name!,
                    email: widget.loggedIn.email!,
                    fullName: widget.loggedIn.fullName!,
                    noTelp: widget.loggedIn.noTelp!,
                    password: widget.loggedIn.password!,
                  ),
                ),
              ).then((_) => refresh());
            },
          ),
          //nanti tambah IconButton disini untuk edit Profile yaa
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ticketInputPage(
                            idTicket: null,
                            asal: null,
                            tujuan: null,
                            harga: null,
                          )),
                ).then((_) => refresh());
              }),
          IconButton(icon: Icon(Icons.clear), onPressed: () async {})
        ],
      ),
    );
  }
}
