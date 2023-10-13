import 'package:flutter/material.dart';
import 'package:transportasi_11/database/sql_helper.dart';

class ticketInputPage extends StatefulWidget {
  const ticketInputPage(
      {super.key, this.asal, this.tujuan, this.harga, this.idTicket, this.id});
  final String? asal, tujuan;
  final int? harga, idTicket, id;
  //int id, String asal, String tujuan, String, double harga
  @override
  State<ticketInputPage> createState() => _ticketInputPageState();
}

class _ticketInputPageState extends State<ticketInputPage> {
  TextEditingController controllerAsal = TextEditingController();
  TextEditingController controllerTujuan = TextEditingController();
  TextEditingController controllerHarga = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.idTicket != null) {
      controllerAsal.text = widget.asal!;
      controllerTujuan.text = widget.tujuan!;
      controllerHarga.text = widget.harga!.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("INPUT Ticket!"),
      ),
      body: ListView(padding: EdgeInsets.all(16), children: [
        TextField(
          controller: controllerAsal,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Asal',
          ),
        ),
        SizedBox(
          height: 24,
        ),
        TextField(
          controller: controllerTujuan,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Tujuan',
          ),
        ),
        SizedBox(height: 24),
        TextField(
          controller: controllerHarga,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Harga',
          ),
        ),
        SizedBox(height: 48),
        ElevatedButton(
          child: Text('Save'),
          onPressed: () async {
            if (widget.idTicket == null) {
              await addTicket();
            } else {
              await editTicket(widget.idTicket!);
            }
            Navigator.pop(context);
          },
        )
      ]),
    );
  }

  Future<void> addTicket() async {
    await SQLHelper.addTicket(widget.id!, controllerAsal.text,
        controllerTujuan.text, int.parse(controllerHarga.text));
  }

  Future<void> editTicket(int idTicket) async {
    await SQLHelper.editTicket(idTicket, widget.id!, controllerAsal.text,
        controllerTujuan.text, int.parse(controllerHarga.text));
  }
}
