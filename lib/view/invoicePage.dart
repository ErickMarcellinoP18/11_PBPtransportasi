import 'package:flutter/material.dart';

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PembayaranPage> createState() => _PembayaranPage();
}

class _PembayaranPage extends State<PembayaranPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Card(
              color: Color.fromRGBO(255, 255, 255, 1),
              child: Padding(
                padding: EdgeInsets.all(
                    16), // Sesuaikan nilai padding yang diinginkan
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Joglosemarkerto (JGS-1)",
                        style: TextStyle(
                          color: Color.fromRGBO(34, 102, 141, 1),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Lempuyangan", //ganti jadi dari
                          style: TextStyle(
                            color: Color.fromRGBO(34, 102, 141, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Icon(Icons.chevron_right,
                            color: Color.fromRGBO(34, 102, 141, 1)),
                        Text(
                          "Solo Balapan", //ganti jadi ke
                          style: TextStyle(
                            color: Color.fromRGBO(34, 102, 141, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "16:33", //ganti jadi jam berangkat
                          style: TextStyle(
                            color: Color.fromRGBO(34, 102, 141, 1),
                          ),
                        ),
                        Icon(Icons.more_vert),
                        Text(
                          "12:40", //ganti jadi jam tiba
                          style: TextStyle(
                            color: Color.fromRGBO(34, 102, 141, 1),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "3 " + "tiket", // ganti jumlah tiket
                        style: TextStyle(
                          color: Color.fromRGBO(34, 102, 141, 1),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 10.0),
            Card(
              color: Color.fromRGBO(255, 255, 255, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      "Nama Akun",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text("Joshua Puniwan Yahya"),
                  ),
                  ListTile(
                    title: Text(
                      "Total Ticket",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text("3 Tiket"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.0),
            Card(
              color: Color.fromRGBO(255, 255, 255, 1),
              child: ListTile(
                title: Text(
                  "Metode Bayar",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 6.0),
            Card(
              color: Color.fromRGBO(255, 255, 255, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      "Ringkasan Pembayaran",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Subtotal"),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text("Rp 12.000"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 7.5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Biaya Layanan"),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text("Rp 1.000"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 7.5),
                ],
              ),
            ),

            // Tambahkan Card sebanyak yang Anda inginkan di sini
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(217, 217, 217, 1),
    );
  }
}
