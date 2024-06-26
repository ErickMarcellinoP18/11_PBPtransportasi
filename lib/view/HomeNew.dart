import 'package:flutter/material.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:transportasi_11/view/Ticket/inputHomePage.dart';
import 'package:transportasi_11/view/souvenir/inputSouvenirPage.dart';

class HomeNew extends StatefulWidget {
  const HomeNew({required this.loggedIn, super.key});

  final User loggedIn;

  @override
  State<HomeNew> createState() => _HomeNewState();
}

class _HomeNewState extends State<HomeNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFD4D1D1),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Stack(clipBehavior: Clip.none, children: [
                  Container(
                    width: double.infinity,
                    child: Image(
                      image: AssetImage(
                          'assets/images/bahan-bakar-kereta-api.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 15,
                    child: Text(
                      'Halo Selamat',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 15,
                    child: Text(
                      'Datang!',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ]),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 700,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10,
                            left: 0,
                            right: 0,
                            child: Container(
                              child: Card(
                                elevation: 3,
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                color: Color(0xFFE0E0E0),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => InputHome(
                                                    loggedIn: widget.loggedIn),
                                              ));
                                        },
                                        child: Column(
                                          children: [
                                            Image(
                                                image: AssetImage(
                                                    'assets/icons/train_antar.png')),
                                            Text("Input Tiket Kereta",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(
                                                      int.parse('0xFF22668D')),
                                                ))
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    InputSouvenir(
                                                        loggedIn:
                                                            widget.loggedIn),
                                              ));
                                        },
                                        child: Column(
                                          children: [
                                            Image(
                                                image: AssetImage(
                                                    'assets/icons/icon_pay.png')),
                                            Text("Input Souvenir",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(
                                                      int.parse('0xFF22668D')),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 100,
                              left: 0,
                              right: 0,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Promo Terbaru",
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )),
                                          Text(
                                            "Lihat Semua",
                                            style: TextStyle(
                                                color: Color(
                                                    int.parse('0xFF22668D'))),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 180,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  width: 300,
                                                  height: 160,
                                                  child: Card(
                                                    elevation: 3,
                                                    margin: EdgeInsets.zero,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image(
                                                        image: AssetImage(
                                                            "assets/images/promo_suite.png"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  "SUITE CLASS COMPARTMENT",
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.65),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  width: 300,
                                                  height: 160,
                                                  child: Card(
                                                    elevation: 3,
                                                    margin: EdgeInsets.zero,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image(
                                                        image: AssetImage(
                                                            "assets/images/promo_grand.png"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  "GRAND ORCHID HOTEL YOGYAKARTA",
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.65),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Tujuan Populer",
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )),
                                          Text(
                                            "Lihat Semua",
                                            style: TextStyle(
                                                color: Color(
                                                    int.parse('0xFF22668D'))),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 180,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  width: 300,
                                                  height: 160,
                                                  child: Card(
                                                    elevation: 3,
                                                    margin: EdgeInsets.zero,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image(
                                                        image: AssetImage(
                                                            "assets/images/tujuan_jogja.png"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  "Tugu Yogyakarta",
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.65),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  width: 300,
                                                  height: 160,
                                                  child: Card(
                                                    elevation: 3,
                                                    margin: EdgeInsets.zero,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image(
                                                        image: AssetImage(
                                                            "assets/images/tujuan_borobudur.png"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  "Candi Borobudur",
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.65),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
