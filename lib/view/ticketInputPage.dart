import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:transportasi_11/data/ticket.dart';
import 'package:transportasi_11/client/TicketClient.dart';

class ticketInputPage extends StatefulWidget {
  const ticketInputPage({super.key, this.idTicket});
  final int? idTicket;

  @override
  State<ticketInputPage> createState() => _ticketInputPageState();
}

class _ticketInputPageState extends State<ticketInputPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String selectedJenis = 'Ekonomi';
  String path = 'assets/images/ekonomi.jpg';
  bool cek = false;
  List<String> destinations = ['Ekonomi', 'Bisnis', 'Eksekutif', 'Private'];
  final controllerAsal = TextEditingController();
  final controllerTujuan = TextEditingController();
  final controllerHarga = TextEditingController();

  void loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      ticket res = await ticketClient.find(widget.idTicket);
      setState(() {
        isLoading = false;
        controllerAsal.value = TextEditingValue(text: res.asal.toString());
        controllerTujuan.value = TextEditingValue(text: res.tujuan.toString());
        controllerHarga.value = TextEditingValue(text: res.harga.toString());
        selectedJenis = res.jenis.toString();
      });
    } catch (err) {
      showSnackBar(context, err.toString(), Colors.red);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.idTicket);
    if (widget.idTicket != null) {
      loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    void onSubmit() async {
      if (!_formKey.currentState!.validate()) return;

      ticket input = ticket(
          IdTicket: widget.idTicket ?? 0,
          asal: controllerAsal.text,
          tujuan: controllerTujuan.text,
          harga: int.parse(controllerHarga.text),
          jenis: selectedJenis);

      try {
        if (widget.idTicket != null) {
          await ticketClient.update(input);
        } else {
          await ticketClient.create(input);
        }

        showSnackBar(context, 'Success', Colors.green);
        Navigator.pop(context);
      } catch (err) {
        showSnackBar(context, err.toString(), Colors.red);
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.idTicket == null ? "Input Ticket" : "Edit Ticket"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _formKey,
                  child: Column(children: [
                    TextField(
                      key: const Key('asal'),
                      controller: controllerAsal,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Asal',
                      ),
                    ),
                    SizedBox(height: 24),
                    TextField(
                      key: const Key('tujuan'),
                      controller: controllerTujuan,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Tujuan',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 20.0, right: 15.0, left: 15.0),
                      child: DropdownButtonFormField<String>(
                        key: const Key('jenis'),
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
                        items: destinations
                            .map<DropdownMenuItem<String>>((String value) {
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
                      key: const Key('harga'),
                      keyboardType: TextInputType.number,
                      controller: controllerHarga,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Harga',
                      ),
                    ),
                    SizedBox(height: 48),
                    ElevatedButton(
                      key: const Key('SaveBtn'),
                      child: Text('Save'),
                      onPressed: onSubmit,
                    )
                  ]),
                ),
        ],
      ),
    );
  }
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
