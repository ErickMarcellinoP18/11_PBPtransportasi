import 'package:flutter/material.dart';
import 'package:transportasi_11/client/JadwalClient.dart';
import 'package:transportasi_11/client/KeretaClient.dart';
import 'package:transportasi_11/data/Jadwal.dart';
import 'package:transportasi_11/data/Kereta.dart';
import 'package:transportasi_11/data/ticket.dart';

class TicketCard extends StatefulWidget {
  const TicketCard({super.key, required this.oneTicket});
  final ticket oneTicket;

  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  late Future<Kereta?> _keretaFuture;
  late Future<Jadwal?> _jadwalFuture;

  Future<Kereta?> findKereta(ticket thisone) async {
    try {
      Kereta onTicket = await KeretaClient.find(thisone.id_kereta);
      return onTicket;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Jadwal?> findJadwal(ticket thisone) async {
    try {
      Jadwal onTicket = await JadwalClient.findById(thisone.id_jadwal!);
      return onTicket;
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _keretaFuture = findKereta(widget.oneTicket);
    _jadwalFuture = findJadwal(widget.oneTicket);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([_keretaFuture, _jadwalFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // or any loading indicator
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Kereta? kereta = snapshot.data![0] as Kereta?;
            Jadwal? jadwal = snapshot.data![1] as Jadwal?;
            return Card();
          }
        });
  }
}
