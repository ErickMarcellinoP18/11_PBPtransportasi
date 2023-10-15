import 'package:flutter/material.dart';
import 'package:transportasi_11/database/sql_helper.dart';

class ticketInputPage extends StatefulWidget {
  const ticketInputPage(
      {super.key,
      this.idTicket,
      this.asal,
      this.tujuan,
      this.harga,
      this.jenis,
      this.gambar});
  final String? asal, tujuan, jenis, gambar;
  final int? harga, idTicket;
  //int id, String asal, String tujuan, String, double harga
  @override
  State<ticketInputPage> createState() => _ticketInputPageState();
}

class _ticketInputPageState extends State<ticketInputPage> {
  String selectedJenis = 'Ekonomi';
  String path = 'assets/images/ekonomi.jpg';
  bool cek = false;
  List<String> destinations = ['Ekonomi', 'Bisnis', 'Eksekutif', 'Private'];
  TextEditingController controllerAsal = TextEditingController();
  TextEditingController controllerTujuan = TextEditingController();
  TextEditingController controllerHarga = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.idTicket != null) {
      controllerAsal.text = widget.asal!;
      controllerTujuan.text = widget.tujuan!;
      controllerHarga.text = widget.harga!.toString();
      if (cek == false) {
        selectedJenis = widget.jenis!;
        path = widget.gambar!;
      }
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
        SizedBox(height: 24),
        TextField(
          controller: controllerTujuan,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Tujuan',
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0, right: 15.0, left: 15.0),
          child: DropdownButtonFormField<String>(
            value: selectedJenis,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              prefixIcon: Icon(Icons.train),
              labelText: 'Jenis Tiket',
            ),
            onChanged: (String? value) {
              setState(() {
                selectedJenis = value!;
                if (value == 'Ekonomi') {
                  path = 'assets/images/ekonomi.jpg';
                } else if (value == 'Bisnis') {
                  path = 'assets/images/bisnis.jpg';
                } else if (value == 'Eksekutif') {
                  path = 'assets/images/eks.jpg';
                } else {
                  path = 'assets/images/priv.jpg';
                }
                cek = true;
              });
            },
            items: destinations.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            validator: (value) =>
                value == null ? 'Pilih jenis tiket anda' : null,
          ),
        ),
        SizedBox(height: 24),
        TextField(
          keyboardType: TextInputType.number,
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
    int harga = int.parse(controllerHarga.text);
    await SQLHelper.addTicket(
        controllerAsal.text, controllerTujuan.text, harga, selectedJenis, path);
  }

  Future<void> editTicket(int idTicket) async {
    await SQLHelper.editTicket(
        widget.idTicket!,
        controllerAsal.text,
        controllerTujuan.text,
        int.parse(controllerHarga.text),
        selectedJenis,
        path);
  }
}
