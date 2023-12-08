import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transportasi_11/client/SouvenirClient.dart';
import 'package:transportasi_11/client/TransaksiClient.dart';
import 'package:transportasi_11/data/souvenir.dart';
import 'package:transportasi_11/data/transaksi.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:transportasi_11/view/souvenir/souvenirCard.dart';
import 'package:transportasi_11/view/pdf/pdf_view.dart';

class SouvenirHomePage extends ConsumerWidget {
  final User loggedIn;
  late final FutureProvider<List<Transaksi>> listSouvenirProvider;

  SouvenirHomePage({Key? key, required this.loggedIn}) : super(key: key) {
    listSouvenirProvider = FutureProvider<List<Transaksi>>((ref) async {
      final loggedInId = loggedIn.id;
      return await TransaksiClient.findByUser(loggedInId);
    });
  }

  double _brightnessValue = 0.1; // Kecerahan awal (0-1)
  double _initialBrightness = 0.5; // Kecerahan awal yang disimpan
  ScreenBrightness screenBrightness = ScreenBrightness();

  // final listTicketProvider = FutureProvider<List<ticket>>((ref) async {
  //   return await ticketClient.findByUser(loggedIn.id);
  // });

  // void onAdd(context, ref) {
  //   Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => const ticketInputPage()))
  //       .then((value) => ref.refresh(listTicketProvider));
  // }

  void onDelete(id, context, ref) async {
    try {
      await TransaksiClient.destroy(id);
      ref.refresh(listSouvenirProvider);
      // showSnackBar(context, "Delete Success", Colors.green);
    } catch (e) {
      // showSnackBar(context, e.toString(), Colors.red);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listener = ref.watch(listSouvenirProvider);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 206, 205, 205),
      appBar: AppBar(
        leading: IconButton(
            color: const Color.fromARGB(255, 255, 250, 221),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Color.fromARGB(255, 34, 102, 141),
        title: Text(
          "Souvenir Anda",
          style: TextStyle(color: Color.fromARGB(255, 255, 250, 221)),
        ),
      ),
      body: ListView.builder(
        itemCount: listener.when(
          data: (tickets) => tickets.length,
          loading: () => 0,
          error: (_, __) => 0,
        ),
        itemBuilder: (context, index) {
          return listener.when(
            data: (transaksis) {
              final transaksi = transaksis[index];
              return Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    child: SouvenirCard(
                  oneTransaksi: transaksi,
                  onDelete: () => onDelete(transaksi.id, context, ref),
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
