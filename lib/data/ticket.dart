class ticket {
  final int? IdTicket;

  String? tujuan, asal;
  int? harga;

  ticket({this.IdTicket, this.asal, this.tujuan, this.harga});
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
