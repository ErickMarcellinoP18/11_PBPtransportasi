import 'package:flutter/material.dart';
import 'package:transportasi_11/client/JadwalClient.dart';
import 'package:transportasi_11/client/KeretaClient.dart';
import 'package:transportasi_11/data/Jadwal.dart';
import 'package:transportasi_11/data/Kereta.dart';
import 'package:transportasi_11/data/client/userClient.dart';
import 'package:transportasi_11/data/ticket.dart';
import 'package:intl/intl.dart';
import 'package:transportasi_11/data/user.dart';

class TicketCard extends StatefulWidget {
  const TicketCard({super.key, required this.oneTicket});
  final ticket oneTicket;

  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  late Future<Kereta?> _keretaFuture;
  late Future<Jadwal?> _jadwalFuture;
  late Future<User?> _userFuture;

  Future<Kereta?> findKereta(ticket thisone) async {
    try {
      Kereta onTicket = await KeretaClient.find(thisone.id_kereta);
      return onTicket;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> findUser(ticket thisone) async {
    try {
      User thisOne = await userClient.find(thisone.id_user);
      return thisOne;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Jadwal?> findJadwal(ticket thisone) async {
    try {
      Jadwal onTicket2 = await JadwalClient.findById(thisone.id_jadwal!);
      return onTicket2;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _keretaFuture = findKereta(widget.oneTicket);
    _jadwalFuture = findJadwal(widget.oneTicket);
    _userFuture = findUser(widget.oneTicket);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([_keretaFuture, _jadwalFuture, _userFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // or any loading indicator
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Kereta? kereta = snapshot.data![0] as Kereta?;
            Jadwal? jadwal = snapshot.data![1] as Jadwal?;
            User? user = snapshot.data![2] as User?;
            return Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 8, left: 16, top: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(DateFormat('dd MMMM yyyy')
                          .format(jadwal!.tanggal)
                          .toString()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(jadwal!.berangkat.toString()),
                            SizedBox(
                              height: 10,
                            ),
                            Text(DateFormat('HH:mm')
                                .format(jadwal!.jam_berangkat)
                                .toString())
                          ],
                        ),
                        Image(
                          image: AssetImage(
                              "assets/images/ticketTemplateAtas.png"),
                          width: 270,
                          height: 50,
                        ),
                        Column(
                          children: [
                            Text(jadwal!.tiba.toString()),
                            SizedBox(
                              height: 10,
                            ),
                            Text(DateFormat('HH:mm')
                                .format(jadwal!.jam_tiba)
                                .toString())
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      height: 20, // Adjust the height of the Divider
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Kereta : " + kereta!.nama.toString()),
                          Column(
                            children: [
                              Text("Kode Tiket"),
                              Text(widget.oneTicket.IdTicket.toString())
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Nama"),
                    Text(user!.fullName.toString()),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Payment Status"),
                    Text(
                      widget.oneTicket.status.toString(),
                      style: TextStyle(
                          color: widget.oneTicket.status.toString() ==
                                  "Sudah Dibayar"
                              ? Colors.blue
                              : Colors.amber),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
