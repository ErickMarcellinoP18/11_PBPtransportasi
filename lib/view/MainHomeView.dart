import 'package:flutter/material.dart';
import 'package:transportasi_11/data/ticket.dart';
import 'package:transportasi_11/data/user.dart';

class TicketHomePage extends StatefulWidget {
  final User loggedIn;
  const TicketHomePage({super.key, required this.loggedIn});

  @override
  State<TicketHomePage> createState() => _TicketHomePageState();
}

class _TicketHomePageState extends State<TicketHomePage> {
  List<Map<String, dynamic>> ticket = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello," + widget.loggedIn.name!),
        actions: [],
      ),
    );
  }
}
