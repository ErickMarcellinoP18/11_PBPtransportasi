import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class TulisReview extends StatefulWidget {
  const TulisReview({super.key, required this.idKereta, required this.idUser});
  final idUser, idKereta;
  @override
  State<TulisReview> createState() => _TulisReviewState();
}

class _TulisReviewState extends State<TulisReview> {
  int _currentValue = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 206, 205, 205),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 34, 102, 141),
        title: const Text("Your Review",
            style: TextStyle(color: Color.fromARGB(255, 255, 250, 221))),
        leading: IconButton(
            color: const Color.fromARGB(255, 255, 250, 221),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "For: ${ambilDataKereta(widget.idKereta)}",
            style: const TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 34, 102, 141),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                "Rekomendasi ",
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 34, 102, 141),
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  showMaterialNumberPicker(
                    backgroundColor: const Color.fromARGB(255, 206, 205, 205),
                    context: context,
                    title: '% Rekomendasi',
                    maxNumber: 100,
                    minNumber: 0,
                    selectedNumber: _currentValue,
                    headerColor: Color.fromARGB(255, 34, 102, 141),
                  ).then((selectedValue) {
                    if (selectedValue != null) {
                      setState(() {
                        _currentValue = selectedValue;
                      });
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text("$_currentValue%"),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const TextField(
            maxLines: 10,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white),
            style: TextStyle(
              color: Color.fromARGB(255, 34, 102, 141),
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 34, 102, 141)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: (() {
                    showSnackBar(context, "Berhasil Memasukkan Review",
                        const Color.fromARGB(255, 34, 102, 141));
                  }),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Submit",
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 250, 221)),
                    ),
                  )))
        ]),
      ),
    );
  }

  String ambilDataKereta(id) {
    return "Kereta SAF JAYA";
  }

  void showSnackBar(BuildContext context, String msg, Color bg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: bg,
      ),
    );
  }
}
