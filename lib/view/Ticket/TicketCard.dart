import 'package:flutter/material.dart';
import 'package:transportasi_11/data/ticket.dart';

class TicketCard extends StatefulWidget {
  const TicketCard({super.key, required this.oneTicket});
  final ticket oneTicket;

  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
