import 'package:transportasi_11/client/SouvenirClient.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:transportasi_11/client/TransaksiClient.dart';
import 'package:transportasi_11/data/transaksi.dart';
import 'package:transportasi_11/data/souvenir.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:transportasi_11/main.dart';
import 'package:transportasi_11/view/home.dart';
import 'package:transportasi_11/view/souvenir/souvenirPage.dart';

class InputSouvenir extends StatefulWidget {
  const InputSouvenir({
    this.idTransaksi,
    required this.loggedIn,
    Key? key,
  }) : super(key: key);
  final int? idTransaksi;
  final User loggedIn;

  @override
  State<InputSouvenir> createState() => _InputSouvenirState();
}

class _InputSouvenirState extends State<InputSouvenir> {
  final _formKey = GlobalKey<FormState>();

  String selectedSouv = '';
  Souvenir? selectedSouvenir;
  TextEditingController controllerJumlah = TextEditingController();
  bool isLoading = false;
  bool cek = false;

  List<String?> souvenir = [];
  List<int?> idSouve = [];
  List<Souvenir> fetchedSouvenir = [];

  void loadList() async {
    try {
      fetchedSouvenir = await SouvenirClient.fetchAll();
      setState(() {
        souvenir = fetchedSouvenir.map((souvenir) => souvenir.nama).toList();
        idSouve = fetchedSouvenir.map((idSouve) => idSouve.id).toList();
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      Transaksi res = await TransaksiClient.find(widget.idTransaksi);
      setState(() {
        isLoading = false;
        selectedSouv = res.id_souvenir.toString();
        controllerJumlah.value = TextEditingValue(text: res.jumlah.toString());
      });
    } catch (err) {
      showSnackBar(context, err.toString(), Colors.red);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.idTransaksi);
    loadList();
    if (widget.idTransaksi != null) {
      loadData();
    }
  }

  void onSubmit(id_user, id_souvenir) async {
    Transaksi input = Transaksi(
      id: widget.idTransaksi ?? 0,
      id_user: id_user,
      id_souvenir: id_souvenir,
      jumlah: int.parse(controllerJumlah.text),
      status: "Belum Dibayar",
    );

    try {
      if (widget.idTransaksi != null) {
        await TransaksiClient.update(input);
        showSnackBar(context, 'Berhasil Mengupdate Souvenir ', Colors.green);
      } else {
        await TransaksiClient.create(input);
        showSnackBar(context, 'Berhasil Menambahkan Souvenir ', Colors.green);
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => HomeView(loggedIn: widget.loggedIn))));
    } catch (err) {
      showSnackBar(context, err.toString(), Colors.red);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(34, 102, 141, 1),
          title: Text(
            widget.idTransaksi == null
                ? "Beli Souvenir"
                : "Edit Pembelian Souvenir",
            style: TextStyle(color: Color.fromRGBO(255, 250, 221, 1)),
          )),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.receipt),
                            labelText: 'Pilih Souvenir',
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              if (value != null) {
                                selectedSouv = value;
                                cek = true;
                                int index = idSouve.indexOf(int.parse(value));
                                selectedSouvenir = index != -1
                                    ? fetchedSouvenir[
                                        index] // Ambil souvenir dari indeks yang dipilih
                                    : null;
                              }
                            });
                          },
                          items: List.generate(
                            souvenir.length,
                            (index) => DropdownMenuItem<String>(
                              value: '${idSouve[index]}',
                              child: Text('${souvenir[index]}'),
                            ),
                          ),
                          validator: (value) =>
                              value == null ? 'Pilih Souvenir Anda!' : null,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: controllerJumlah,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.tag_sharp),
                            labelText: 'Jumlah',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Center(
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: selectedSouvenir != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nama: ${selectedSouvenir?.nama ?? "Tidak ada nama"}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      'Harga: ${selectedSouvenir?.harga ?? "Tidak ada harga"}',
                                    ),
                                    // Tambahkan informasi lain sesuai kebutuhan
                                  ],
                                )
                              : Text(
                                  'Silahkan pilih Souvenir',
                                  style: TextStyle(fontSize: 18),
                                ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _showConfirmationDialog(
                            context, widget.loggedIn.id, selectedSouvenir!.id);
                      },
                      child: Text(widget.idTransaksi == null
                          ? "Tambah Souvenir"
                          : "Edit Pembelian Souvenir"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  void _showConfirmationDialog(BuildContext context, idUser, idSouvenir) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah anda yakin ingin membeli pesan ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // Panggil fungsi onSubmit jika user mengonfirmasi
                onSubmit(idUser, idSouvenir); // Tutup dialog
              },
              child: Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}
