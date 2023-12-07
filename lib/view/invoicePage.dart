import 'package:transportasi_11/client/JadwalClient.dart';
import 'package:transportasi_11/client/KeretaClient.dart';
import 'package:transportasi_11/client/TicketClient.dart';
import 'package:transportasi_11/data/client/userClient.dart';
import 'package:transportasi_11/data/jadwal.dart';
import 'package:transportasi_11/data/Kereta.dart';
import 'package:transportasi_11/data/ticket.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transportasi_11/view/Ticket/TicketPage.dart';

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({
    required this.oneTiket,
    Key? key,
  }) : super(key: key);

  final ticket oneTiket;

  @override
  State<PembayaranPage> createState() => _PembayaranPage();
}

class _PembayaranPage extends State<PembayaranPage>
    with TickerProviderStateMixin {
  int harga = 1000;
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
    _keretaFuture = findKereta(widget.oneTiket);
    _jadwalFuture = findJadwal(widget.oneTiket);
    _userFuture = findUser(widget.oneTiket);
  }

  void onSubmission() async {
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss')
        .format(DateTime.parse(widget.oneTiket.tanggal_pergi));
    ticket input = ticket(
      IdTicket: widget.oneTiket.IdTicket,
      id_user: widget.oneTiket.id_user,
      id_jadwal: widget.oneTiket.id_jadwal,
      id_kereta: widget.oneTiket.id_kereta,
      asal: widget.oneTiket.asal,
      tujuan: widget.oneTiket.tujuan,
      jumlah: widget.oneTiket.jumlah,
      tanggal_pergi: formattedDate,
      status: "Sudah Dibayar",
    );

    try {
      await ticketClient.update(input);
      showSnackBar(context, 'Success Membayar', Colors.green);
    } catch (err) {
      showSnackBar(context, err.toString(), Colors.red);
      Navigator.pop(context);
    }
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
            return Scaffold(
              appBar: AppBar(
                title: const Text('Pembayaran'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    Card(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      child: Padding(
                        padding: EdgeInsets.all(
                            16), // Sesuaikan nilai padding yang diinginkan
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                kereta!.nama.toString() +
                                    '  ' +
                                    widget.oneTiket.id_kereta.toString(),
                                style: TextStyle(
                                  color: Color.fromRGBO(34, 102, 141, 1),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.oneTiket.asal
                                      .toString(), //ganti jadi dari
                                  style: TextStyle(
                                    color: Color.fromRGBO(34, 102, 141, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(Icons.chevron_right,
                                    color: Color.fromRGBO(34, 102, 141, 1)),
                                Text(
                                  widget.oneTiket.tujuan
                                      .toString(), //ganti jadi ke
                                  style: TextStyle(
                                    color: Color.fromRGBO(34, 102, 141, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  DateFormat('HH:mm')
                                      .format(jadwal!.jam_berangkat)
                                      .toString(), //ganti jadi jam berangkat
                                  style: TextStyle(
                                    color: Color.fromRGBO(34, 102, 141, 1),
                                  ),
                                ),
                                Icon(Icons.more_vert),
                                Text(
                                  DateFormat('HH:mm')
                                      .format(jadwal!.jam_tiba)
                                      .toString(), //ganti jadi jam tiba
                                  style: TextStyle(
                                    color: Color.fromRGBO(34, 102, 141, 1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Card(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              "Nama Akun",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(user!.fullName.toString()),
                          ),
                          ListTile(
                            title: Text(
                              "Total Ticket",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                                widget.oneTiket.jumlah.toString() + " Tiket"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Card(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      child: ListTile(
                        title: Text(
                          "Metode Bayar",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Card(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              "Ringkasan Pembayaran",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Subtotal"),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Rp " +
                                        (widget.oneTiket.jumlah! *
                                                jadwal.harga!)
                                            .toString(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 7.5),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Biaya Layanan"),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("Rp " + '${harga}'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 7.5),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        onSubmission();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TicketHomePage(
                                  loggedIn:
                                      user)), // nanti ini kukelarin dulu di source ku
                        );
                      },
                      child: Text("Bayar"),
                    ),
                  ],
                ),
              ),
              backgroundColor: Color.fromRGBO(217, 217, 217, 1),
            );
          }
        });
  }

  void showSnackBar(BuildContext context, String msg, Color bg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: bg,
        action: SnackBarAction(
            label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
