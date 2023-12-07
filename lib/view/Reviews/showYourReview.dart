import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyReview extends StatefulWidget {
  const MyReview({super.key, required this.idKereta, required this.idUser});
  final idKereta, idUser;

  @override
  State<MyReview> createState() => _MyReviewState();
}

class _MyReviewState extends State<MyReview> {
  TextStyle textKeren = const TextStyle(
      color: Color.fromARGB(255, 34, 102, 141),
      fontWeight: FontWeight.bold,
      fontSize: 20);
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
        padding: const EdgeInsets.only(top: 15, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "For: ${ambilDataKereta(widget.idKereta)}",
                style: const TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 34, 102, 141),
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ambilDataReview(widget.idUser) != null
                ? Card(
                    child: Slidable(
                      key: const ValueKey(0),
                      endActionPane: const ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            flex: 1,
                            onPressed: null,
                            backgroundColor: Color.fromARGB(255, 34, 102, 141),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: 'Update',
                          ),
                          SlidableAction(
                            onPressed: null,
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  ambilDataPengguna(1),
                                  style: textKeren,
                                ),
                                const SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  "70%",
                                  style: textKeren,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              ambilDataReview(1)!,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 34, 102, 141),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 200,
                  ),
            const Positioned.fill(
                child: Align(
              alignment: Alignment.center,
              child: Text(
                "Masih Belum Ada Review!",
                style: TextStyle(
                    color: Color.fromARGB(255, 34, 102, 141),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            )),
          ],
        ),
      ),
    );
  }

  String ambilDataKereta(id) {
    return "Kereta SAF JAYA";
  }

  String ambilDataPengguna(id) {
    return "You";
  }

  String? ambilDataReview(id) {}
}
