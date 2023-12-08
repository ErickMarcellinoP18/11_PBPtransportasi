import 'package:flutter/material.dart';

class HomeNew extends StatefulWidget {
  const HomeNew({super.key});

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
                  Positioned(
                    bottom:
                        -40, // Sesuaikan dengan jumlah yang diinginkan agar card keluar dari bawah gambar
                    left: 15,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Sesuaikan nilai dengan keinginan Anda
                      ),
                      color: Colors.white,
                      elevation: 5,
                      child: Container(
                        width: 350,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Column(children: [
                                            Row(
                                              children: [
                                                Image(
                                                    image: AssetImage(
                                                        'assets/icons/icon_pay.png')),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'PAY',
                                                  style: TextStyle(
                                                      fontSize: 23,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ]),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Metode',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(Icons.arrow_forward_ios,
                                                  size: 20,
                                                  color: Color(
                                                      int.parse('0xFF22668D')))
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 90,
                                        width: 3,
                                        color: Colors.blue[300],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Image(
                                                  image: AssetImage(
                                                      "assets/icons/icon_scan.png")),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Scan",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black
                                                      .withOpacity(0.35),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [
                                              Image(
                                                  image: AssetImage(
                                                      'assets/icons/icon_wallet.png')),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Top Up',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black
                                                      .withOpacity(0.35),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ]),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 330,
                                    height: 3,
                                    color: Colors.blue[300],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image(
                                                image: AssetImage(
                                                    'assets/icons/icon_coin.png')),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text("RailPoint",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black
                                                      .withOpacity(0.35),
                                                ))
                                          ],
                                        ),
                                        Text(
                                          "Detail",
                                          style: TextStyle(
                                            color:
                                                Color(int.parse('0xFF90B2C6')),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 50,
                ),
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
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Image(
                                              image: AssetImage(
                                                  'assets/icons/train_antar.png')),
                                          Text("Antar Kota",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Color(
                                                    int.parse('0xFF22668D')),
                                              ))
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Image(
                                              image: AssetImage(
                                                  'assets/icons/train_lokal.png')),
                                          Text("Lokal",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Color(
                                                    int.parse('0xFF22668D')),
                                              ))
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Image(
                                              image: AssetImage(
                                                  'assets/icons/train_comuter.png')),
                                          Text(
                                            "Commuter Line",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(
                                                  int.parse('0xFF22668D')),
                                            ),
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Image(
                                              image: AssetImage(
                                                  'assets/icons/train_lrt.png')),
                                          Text("LRT",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Color(
                                                    int.parse('0xFF22668D')),
                                              ))
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Image(
                                              image: AssetImage(
                                                  'assets/icons/train_bandara.png')),
                                          Text("Bandara",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Color(
                                                    int.parse('0xFF22668D')),
                                              ))
                                        ],
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