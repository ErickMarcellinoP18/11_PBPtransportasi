import 'package:flutter/material.dart';
import 'package:transportasi_11/data/ticket.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:transportasi_11/database/sql_helper.dart';
import 'package:transportasi_11/view/ticketInputPage.dart';
import 'package:transportasi_11/view/register.dart';
import 'package:transportasi_11/view/profile.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:transportasi_11/view/pdf_view.dart';

class TicketHomePage extends StatefulWidget {
  final User loggedIn;
  const TicketHomePage({Key? key, required this.loggedIn}) : super(key: key);

  @override
  State<TicketHomePage> createState() => _TicketHomePageState();
}

class _TicketHomePageState extends State<TicketHomePage> {
  double _brightnessValue = 0.1; // Kecerahan awal (0-1)
  double _initialBrightness = 0.5; // Kecerahan awal yang disimpan
  ScreenBrightness screenBrightness = ScreenBrightness();

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (event.z < 0) {
        // orientation = "atas";
        setMaxBrightness();
      } else {
        // orientation = "bawah";
        setMinBrightness();
      }
      setState(() {});
    });
  }

  List<Map<String, dynamic>> ticket = [];
  void refresh() async {
    final data = await SQLHelper.getTicket();
    setState(() {
      ticket = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 206, 205, 205),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 34, 102, 141),
        title: Text(
          "History",
          style: TextStyle(color: Color.fromARGB(255, 255, 250, 221)),
        ),
        actions: [
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
                            jenis: null,
                            gambar: null,
                          )),
                ).then((_) => refresh());
              }),
        ],
      ),
      body: ListView.builder(
        itemCount: ticket.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 150,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Container(
                        width: 100,
                        child: Center(
                          child: QrImageView(
                            data: 'pbptransport' +
                                ticket[index]['idTicket'].toString(),
                            version: 6,
                            // padding: const EdgeInsets.all(50),
                            // child: Image(
                            //   image: AssetImage(ticket[index]['gambar']),
                          ),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 50,
                            child: Text(
                              "Dari Kota : " + ticket[index]['asal'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Divider(
                          thickness: 50,
                          color: Theme.of(context).colorScheme.primary,
                          indent: BorderSide.strokeAlignCenter,
                        ),
                        Container(
                          // ignore: prefer_interpolation_to_compose_strings
                          child: Text("Ke Kota : " + ticket[index]['tujuan']),
                        ),
                        Container(
                          child: Text(
                              "Harga : " + ticket[index]['harga'].toString()),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ticketInputPage(
                                            asal: ticket[index]['asal'],
                                            harga: ticket[index]['harga'],
                                            idTicket: ticket[index]['idTicket'],
                                            tujuan: ticket[index]['tujuan'],
                                            jenis: ticket[index]['jenis'],
                                            gambar: ticket[index]['gambar'],
                                          ))).then((_) => refresh());
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () async {
                              await deleteTicket(ticket[index]['idTicket']);
                            },
                            icon: Icon(Icons.delete)),
                        buttonCreatePDF(
                          context,
                          ticket[index]['asal'],
                          ticket[index]['harga'],
                          ticket[index]['idTicket'],
                          ticket[index]['tujuan'],
                          ticket[index]['jenis'],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> deleteTicket(int id) async {
    await SQLHelper.deleteTicket(id);
    refresh();
  }

  Future<void> setMaxBrightness() async {
    await screenBrightness.setScreenBrightness(1.0);

    setState(() {
      _brightnessValue = 1.0;
    });
  }

  Future<void> setMinBrightness() async {
    await screenBrightness.setScreenBrightness(0.1);

    setState(() {
      _brightnessValue = 0.1;
    });
  }
}

Container buttonCreatePDF(BuildContext context, String asal, int harga,
    int idTicket, String tujuan, String jenis) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2),
    child: ElevatedButton(
      onPressed: () {
        createPdf(asal, harga, idTicket, tujuan, jenis, context);
      },
      style: ElevatedButton.styleFrom(backgroundColor: null),
      child: const Icon(Icons.print),
    ),
  );
}
