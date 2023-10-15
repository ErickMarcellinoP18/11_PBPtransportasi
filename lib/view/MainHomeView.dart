import 'package:flutter/material.dart';
import 'package:transportasi_11/data/ticket.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:transportasi_11/database/sql_helper.dart';
import 'package:transportasi_11/view/ticketInputPage.dart';
import 'package:transportasi_11/view/register.dart';
import 'package:transportasi_11/view/profile.dart';

class TicketHomePage extends StatefulWidget {
  final User loggedIn;
  const TicketHomePage({super.key, required this.loggedIn});

  @override
  State<TicketHomePage> createState() => _TicketHomePageState();
}

class _TicketHomePageState extends State<TicketHomePage> {
  List<Map<String, dynamic>> ticket = [];
  void refresh() async {
    final data = await SQLHelper.getTicket();
    setState(() {
      ticket = data;
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello,${widget.loggedIn.name!}"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (_) => const ProfileView(),
                  builder: (_) => ProfileView(
                    id: widget.loggedIn.id!,
                    name: widget.loggedIn.name!,
                    email: widget.loggedIn.email!,
                    fullName: widget.loggedIn.fullName!,
                    noTelp: widget.loggedIn.noTelp!,
                    password: widget.loggedIn.password!,
                  ),
                ),
              ).then((_) => refresh());
            },
          ),
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
                          )),
                ).then((_) => refresh());
              }),
          IconButton(icon: Icon(Icons.clear), onPressed: () async {})
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
                          child: Image(
                            image: AssetImage(ticket[index]['gambar']),
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
                                          ))).then((_) => refresh());
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () async {
                              await deleteTicket(ticket[index]['idTicket']);
                            },
                            icon: Icon(Icons.delete)),
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

  String setImage(int harga) {
    if (harga < 1000) {
      return 'assets/images/KABandara.png';
    } else if (harga > 1000 && harga < 20000) {
      return 'assets/images/download.jpeg';
    } else {
      return 'assets/images/Laufey1.jpg';
    }
  }
}
