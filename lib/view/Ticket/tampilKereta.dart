import 'package:quickalert/quickalert.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:transportasi_11/client/JadwalClient.dart';
import 'package:transportasi_11/client/TicketClient.dart';
import 'package:transportasi_11/data/jadwal.dart';
import 'package:transportasi_11/data/ticket.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:transportasi_11/main.dart';
import 'package:transportasi_11/view/Reviews/reviewKereta.dart';
import 'package:transportasi_11/view/Ticket/TicketPage.dart';
import 'package:transportasi_11/view/Ticket/inputHomePage.dart';
import 'package:transportasi_11/view/home.dart';
import 'package:transportasi_11/view/invoicePage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListViewKereta extends StatefulWidget {
  final User loggedIn;
  final String selectedDate;
  final String selectedDari;
  final String selectedKe;
  final int penumpang;
  final int? idTicket;
  final int idUser;

  const ListViewKereta({
    required this.selectedDate,
    required this.selectedDari,
    required this.selectedKe,
    required this.penumpang,
    this.idTicket,
    required this.idUser,
    required this.loggedIn,
    Key? key,
  }) : super(key: key);

  @override
  State<ListViewKereta> createState() => _ListViewKeretaState();
}

class _ListViewKeretaState extends State<ListViewKereta>
    with TickerProviderStateMixin {
  // List untuk menyimpan tanggal-tanggal
  late final DateTime parsedSelectedDate =
      DateFormat('EEEE, dd MMMM yyyy').parse(widget.selectedDate);
  List<DateTime> listDate = [];
  late final Map<DateTime, List<Jadwal>> jadwalMap = {};
  late DateTime selectedDate = parsedSelectedDate;

  double _brightnessValue = 0.1; // Kecerahan awal (0-1)
  double _initialBrightness = 0.7; // Kecerahan awal yang disimpan
  ScreenBrightness screenBrightness = ScreenBrightness();

  // double x = 0, y = 0, z = 0;

  @override
  void initState() {
    super.initState();
    generateDateList();
    fetchJadwalData(parsedSelectedDate);

    accelerometerEvents.listen((AccelerometerEvent event) {
      if (event.z < 0) {
        setMaxBrightness();
      } else {
        setMinBrightness();
      }
    });
  }

  void generateDateList() {
    listDate.clear(); // Bersihkan list sebelum menambahkan tanggal baru
    for (int i = 0; i < 4; i++) {
      DateTime newDate = parsedSelectedDate.add(Duration(days: i));
      listDate.add(newDate);
      print(newDate);
    }
  }

  void onSubmit(id_jadwal, id_kereta, tanggal) async {
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(tanggal);
    ticket input = ticket(
      IdTicket: widget.idTicket ?? 0,
      id_user: widget.idUser,
      id_jadwal: id_jadwal,
      id_kereta: id_kereta,
      asal: widget.selectedDari,
      tujuan: widget.selectedKe,
      jumlah: widget.penumpang,
      tanggal_pergi: formattedDate,
      status: "Belum Dibayar",
    );

    try {
      if (widget.idTicket != null) {
        await ticketClient.update(input);
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Berhasil Mengupdate Tiket!',
        );
      } else {
        await ticketClient.create(input);
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Berhasil Menginput Tiket!',
        );
      }
    } catch (err) {
      showSnackBar(context, err.toString(), Colors.red);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: listDate.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(34, 102, 141, 1),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.selectedDari,
                      style:
                          TextStyle(color: Color.fromRGBO(255, 250, 221, 1))),
                  Icon(Icons.chevron_right),
                  Text(widget.selectedKe,
                      style:
                          TextStyle(color: Color.fromRGBO(255, 250, 221, 1))),
                ],
              ),
              Text(widget.selectedDate,
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 14,
                      color: Color.fromRGBO(255, 220, 221, 1))),
            ],
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: List.generate(
              listDate.length,
              (index) => Tab(
                text: DateFormat('EEEE, dd MMMM').format(listDate[index]),
              ),
            ),
            indicatorColor: Color.fromRGBO(142, 205, 221, 1),
            unselectedLabelColor: Color.fromRGBO(217, 217, 217, 1),
            onTap: (index) {
              setState(() {
                selectedDate = listDate[index]; // Update selected date
              });
              if (widget.idTicket != null) {
                fetchJadwalData(parsedSelectedDate);
              } else {
                fetchJadwalData(selectedDate); // Fetch data for selected date
              }
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10), // Beri sedikit jarak dari AppBar
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0), // Atur padding jika diperlukan
              child: Text(
                'Pilih Kereta',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.0), // Padding untuk TabBarView
                child: TabBarView(
                  children: List.generate(
                    listDate.length,
                    (index) => Center(
                      child: buildJadwalList(listDate[index]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchJadwalData(DateTime date) async {
    try {
      List<Jadwal> jadwalData = await JadwalClient.find(
        widget.selectedDari,
        widget.selectedKe,
        date,
      );
      setState(() {
        if (jadwalData != null) {
          jadwalMap[date] = jadwalData;
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> setMaxBrightness() async {
    await screenBrightness.setScreenBrightness(1.0);
  }

  Future<void> setMinBrightness() async {
    await screenBrightness.setScreenBrightness(0.5);
  }

  Widget buildJadwalList(DateTime date) {
    if (jadwalMap.containsKey(date)) {
      List<Jadwal> jadwalData = jadwalMap[date]!;
      if (jadwalData.isEmpty) {
        return const Center(
          child: Text('Data not available for selected date'),
        );
      }
      return ListView.builder(
        itemCount: jadwalData.length,
        itemBuilder: (context, idx) {
          return GestureDetector(
            onTap: () {
              _showConfirmationDialog(context, jadwalData[idx].idJadwal,
                  jadwalData[idx].idKereta, jadwalData[idx].tanggal);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6.0),
              child: Card(
                color: Color.fromRGBO(217, 217, 217, 1),
                child: Padding(
                  padding: EdgeInsets.all(
                      10.0), // Ubah nilai padding sesuai kebutuhan
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReviewKereta(
                                      idKereta: jadwalData[idx]
                                          .idKereta!)), // Ganti InvoicePage dengan halaman yang sesuai
                            );
                          },
                          child: Text(
                            '${jadwalData[idx].namaKereta}',
                            style: TextStyle(
                              color: Color.fromRGBO(34, 102, 141, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '(${jadwalData[idx].idKereta})   ${jadwalData[idx].rating}% recommended',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start, // Ubah ke MainAxisAlignment.spaceBetween
                        children: [
                          Text(
                            DateFormat('HH:mm')
                                .format(jadwalData[idx].jam_berangkat),
                            style: const TextStyle(
                              color: Color.fromRGBO(34, 102, 141, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Icon(Icons.linear_scale),
                          Text(
                            DateFormat('HH:mm')
                                .format(jadwalData[idx].jam_tiba),
                            style: const TextStyle(
                              color: Color.fromRGBO(34, 102, 141, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start, // Ubah ke MainAxisAlignment.spaceBetween
                        children: [
                          const SizedBox(width: 9.0),
                          Text(
                            '${jadwalData[idx].berangkat}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(width: 40.0),
                          Text(
                            '${jadwalData[idx].tiba}',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8), // Tambahkan jarak antara baris
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Harga mulai dari",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Rp. ${jadwalData[idx].harga}',
                          style: TextStyle(
                            color: Color.fromRGBO(34, 102, 141, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      if (widget.idTicket != null) {
        return const Center(
          child: Text('Anda tidak bisa memilih jadwal yang berbeda hari'),
        );
      } else {
        return const Center(
          child: Text('Data not available for selected date'),
        );
      }
    }
  }

  void _showConfirmationDialog(
      BuildContext context, idJadwal, idKereta, DateTime tanggal) {
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
                onSubmit(idJadwal, idKereta, tanggal);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeView(
                          loggedIn: widget
                              .loggedIn)), // Ganti InvoicePage dengan halaman yang sesuai
                ); // Tutup dialog
              },
              child: Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}
