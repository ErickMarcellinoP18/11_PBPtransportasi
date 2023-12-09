import 'package:flutter/rendering.dart';
import 'package:transportasi_11/data/stasiun.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:transportasi_11/view/Ticket/tampilKereta.dart';
import 'package:transportasi_11/client/StasiunClient.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:transportasi_11/client/TicketClient.dart';
import 'package:transportasi_11/data/ticket.dart';

class InputHome extends StatefulWidget {
  final User loggedIn;

  const InputHome({
    this.idTicket,
    required this.loggedIn,
    Key? key,
  }) : super(key: key);
  final String? idTicket;

  @override
  State<InputHome> createState() => _InputHomeState();
}

class _InputHomeState extends State<InputHome> {
  final _formKey = GlobalKey<FormState>();
  String selectedKe = '';
  String selectedDari = '';
  String selectedDate = '';
  TextEditingController controllerPenumpang = TextEditingController();
  bool isLoading = false;
  bool cek = false;

  void loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      ticket res = await ticketClient.find(widget.idTicket);
      setState(() {
        isLoading = false;
        selectedDari = res.asal.toString();
        selectedKe = res.tujuan.toString();
        controllerPenumpang.value =
            TextEditingValue(text: res.jumlah.toString());
      });
    } catch (err) {
      showSnackBar(context, err.toString(), Colors.red);
      Navigator.pop(context);
    }
  }

  List<String?> stasiun = [];

  List<String?> kota = [];
  List<String?> kode = [];
  void loadList() async {
    try {
      List<Stasiun> fetchedStations = await stasiunClient.fetchAll();

      setState(() {
        stasiun = fetchedStations.map((stasiun) => stasiun.nama).toList();
        kota = fetchedStations.map((stasiun) => stasiun.kota).toList();
        kode = fetchedStations.map((stasiun) => stasiun.id).toList();
      });
    } catch (e) {
      print('Error: $e');
      // Handle error jika terjadi kesalahan saat mengambil data dari API
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.idTicket);
    loadList();
    if (widget.idTicket != null) {
      loadData();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('EEEE, dd MMMM yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    controllerPenumpang.text = '1';
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/download.png",
            fit: BoxFit.cover,
          ),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode
                .onUserInteraction, // Aktifkan validasi otomatis
            child: LayoutBuilder(
              builder: (context, constraints) => Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          constraints: BoxConstraints(maxWidth: 380),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              left: 8.0,
                              right: 8.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.train),
                                    labelText: 'Dari',
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      if (value != null) {
                                        selectedDari = value;
                                        cek = true;
                                      }
                                    });
                                  },
                                  items: List.generate(
                                    stasiun.length,
                                    (index) => DropdownMenuItem<String>(
                                      value: '${kode[index]}',
                                      child: Text(
                                          '${stasiun[index]} - ${kota[index]}'),
                                    ),
                                  ),
                                  validator: (value) => value == null
                                      ? 'Pilih Stasiun Kepergiaan anda!'
                                      : null,
                                ),
                                const SizedBox(height: 20),
                                DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.train),
                                    labelText: 'Ke',
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      if (value != null) {
                                        selectedKe = value;
                                        cek = true;
                                      }
                                    });
                                  },
                                  items: List.generate(
                                    stasiun.length,
                                    (index) => DropdownMenuItem<String>(
                                      value: '${kode[index]}',
                                      child: Text(
                                          '${stasiun[index]} - ${kota[index]}'),
                                    ),
                                  ),
                                  validator: (value) => value == null
                                      ? 'Pilih Stasiun Tujuan Anda!'
                                      : null,
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Tanggal',
                                    prefixIcon: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _selectDate(context);
                                          },
                                          child: Icon(Icons.calendar_today),
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                  ),
                                  validator: (value) {
                                    if (selectedDate.isEmpty) {
                                      return 'Pilih Tanggal Keberangkatan Anda';
                                    }
                                    return null;
                                  },
                                  controller: TextEditingController(
                                    text: selectedDate.isEmpty
                                        ? null
                                        : selectedDate,
                                  ),
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: controllerPenumpang,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.person),
                                    labelText: 'Penumpang',
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // onSubmit();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ListViewKereta(
                                                selectedDate: selectedDate,
                                                selectedDari: selectedDari,
                                                selectedKe: selectedKe,
                                                penumpang: int.parse(
                                                    controllerPenumpang.text),
                                                idUser: widget.loggedIn.id!,
                                                loggedIn: widget
                                                    .loggedIn, //nanti ini ubah lagi
                                              ), // Pastikan variabel selectedDate sudah dideklarasikan di tempat yang sesuai
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text('Cari Tiket'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
