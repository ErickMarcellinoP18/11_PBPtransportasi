import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:transportasi_11/client/SouvenirClient.dart';
import 'package:transportasi_11/client/TransaksiClient.dart';
import 'package:transportasi_11/data/jadwal.dart';
import 'package:transportasi_11/data/kereta.dart';
import 'package:transportasi_11/data/client/userClient.dart';
import 'package:transportasi_11/data/souvenir.dart';
import 'package:transportasi_11/data/ticket.dart';
import 'package:intl/intl.dart';
import 'package:transportasi_11/data/transaksi.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:transportasi_11/view/Reviews/TulisReview.dart';
import 'package:transportasi_11/view/Ticket/tampilKereta.dart';
import 'package:transportasi_11/view/invoicePage.dart';
import 'package:transportasi_11/view/pdf/pdf_view.dart';
import 'package:transportasi_11/view/souvenir/inputSouvenirPage.dart';

class SouvenirCard extends StatefulWidget {
  const SouvenirCard(
      {super.key, required this.oneTransaksi, required this.onDelete});
  final Transaksi oneTransaksi;
  final VoidCallback onDelete;

  @override
  State<SouvenirCard> createState() => _SouvenirCardState();
}

class _SouvenirCardState extends State<SouvenirCard> {
  late Future<Souvenir?> _souvenirFuture;
  late Future<User?> _userFuture;

  Future<Souvenir?> findSouvenir(Transaksi thisone) async {
    try {
      Souvenir onSouvenir = await SouvenirClient.find(thisone.id_souvenir);
      return onSouvenir;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> findUser(Transaksi thisone) async {
    try {
      User thisOne = await userClient.find(thisone.id_user);
      return thisOne;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _souvenirFuture = findSouvenir(widget.oneTransaksi);
    _userFuture = findUser(widget.oneTransaksi);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([_souvenirFuture, _userFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // or any loading indicator
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Souvenir? souvenir = snapshot.data![0] as Souvenir?;
            User? user = snapshot.data![1] as User?;
            return Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 8, left: 16, top: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        souvenir!.nama.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Divider(
                      height: 20,
                      color: Colors.grey,
                    ),
                    Text("Nama"),
                    Text(user!.fullName.toString()),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Jumlah"),
                    Text(widget.oneTransaksi.jumlah.toString()),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Payment Status"),
                    Text(
                      widget.oneTransaksi.status.toString(),
                      style: TextStyle(
                          color: widget.oneTransaksi.status.toString() ==
                                  "Sudah Dibayar"
                              ? Colors.blue
                              : Colors.amber),
                    ),
                    Divider(
                      height: 20, // Adjust the height of the Divider
                      color: Colors.grey,
                    ),
                    Row(
                      children: [
                        if (widget.oneTransaksi.status.toString() ==
                            "Sudah Dibayar")
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                IconButton(
                                    onPressed: widget.onDelete,
                                    icon: Icon(Icons.delete))
                              ],
                            ),
                          )
                        else if (widget.oneTransaksi.status.toString() ==
                            "Belum Dibayar")
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => InputSouvenir(
                                            idTransaksi: widget.oneTransaksi.id,
                                            loggedIn: user,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.edit)),
                                // TextButton(
                                //     onPressed: () {
                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: ((context) =>
                                //                 PembayaranPage(
                                //                   oneTiket: widget.oneTicket,
                                //                 ))), // nanti ini kukelarin dulu di source ku
                                //       );
                                //     },
                                //     child: Text("PAY")),
                                IconButton(
                                    onPressed: widget.onDelete,
                                    icon: Icon(Icons.delete))
                              ],
                            ),
                          )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
