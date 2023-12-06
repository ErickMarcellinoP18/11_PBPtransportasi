import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transportasi_11/data/ticket.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:transportasi_11/database/sql_helper.dart';
import 'package:transportasi_11/view/Ticket/TicketCard.dart';
// import 'package:transportasi_11/view/Ticket/ticketInputPage.dart';
import 'package:transportasi_11/view/loginRegistResetPass/register.dart';
import 'package:transportasi_11/view/profile/profile.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:transportasi_11/view/pdf/pdf_view.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:transportasi_11/client/TicketClient.dart';

class TicketHomePage extends ConsumerWidget {
  final User loggedIn;
  TicketHomePage({Key? key, required this.loggedIn}) : super(key: key);

  double _brightnessValue = 0.1; // Kecerahan awal (0-1)
  double _initialBrightness = 0.5; // Kecerahan awal yang disimpan
  ScreenBrightness screenBrightness = ScreenBrightness();

  final listTicketProvider = FutureProvider<List<ticket>>((ref) async {
    return await ticketClient.fetchAll();
  });

  // void onAdd(context, ref) {
  //   Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => const ticketInputPage()))
  //       .then((value) => ref.refresh(listTicketProvider));
  // }

  void onDelete(id, context, ref) async {
    try {
      await ticketClient.destroy(id);
      ref.refresh(listTicketProvider);
      // showSnackBar(context, "Delete Success", Colors.green);
    } catch (e) {
      // showSnackBar(context, e.toString(), Colors.red);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listener = ref.watch(listTicketProvider);

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
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: listener.when(
          data: (tickets) => tickets.length,
          loading: () => 0,
          error: (_, __) => 0,
        ),
        itemBuilder: (context, index) {
          return listener.when(
            data: (tickets) {
              final ticket = tickets[index];
              return Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    height: 150,
                    child: TicketCard(
                      oneTicket: ticket,
                    )),
              );
            },
            error: (err, s) => Center(child: Text(err.toString())),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Future<void> deleteTicket(int id) async {
    await SQLHelper.deleteTicket(id);
  }

  Future<void> setMaxBrightness() async {
    await screenBrightness.setScreenBrightness(1.0);
  }

  Future<void> setMinBrightness() async {
    await screenBrightness.setScreenBrightness(0.5);
  }

  Container buttonCreatePDF(BuildContext context, String asal, int harga,
      String idTicket, String tujuan, String jenis) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: ElevatedButton(
        onPressed: () {
          if (asal.isEmpty) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Warning'),
                content: const Text('Please fill in all the fields.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            return;
          } else {
            createPdf(asal, harga, idTicket, tujuan, jenis, context);
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: null),
        child: const Icon(Icons.print),
      ),
    );
  }
}
