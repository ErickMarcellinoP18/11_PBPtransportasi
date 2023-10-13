import 'package:flutter/material.dart';
import 'package:transportasi_11/data/ticket.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:transportasi_11/database/sql_helper.dart';
import 'package:transportasi_11/view/ticketInputPage.dart';

class TicketHomePage extends StatefulWidget {
  final User loggedIn;
  const TicketHomePage({super.key, required this.loggedIn});

  @override
  State<TicketHomePage> createState() => _TicketHomePageState();
}

class _TicketHomePageState extends State<TicketHomePage> {
  List<Map<String, dynamic>> ticket = [];
  void refresh() async {
    final data = await SQLHelper.getTicket();
    setState(() {
      ticket = data;
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
