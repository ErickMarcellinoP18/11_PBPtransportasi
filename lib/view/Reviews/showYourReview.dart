import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:transportasi_11/client/KeretaClient.dart';
import 'package:transportasi_11/client/ReviewClient.dart';
import 'package:transportasi_11/data/kereta.dart';
import 'package:transportasi_11/data/review.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:transportasi_11/view/Reviews/TulisReview.dart';

class MyReview extends StatefulWidget {
  const MyReview({super.key, required this.kereta, required this.user});
  final Kereta kereta;
  final User user;

  @override
  State<MyReview> createState() => _MyReviewState();
}

class _MyReviewState extends State<MyReview> {
  Review? kaloada;
  TextStyle textKeren = const TextStyle(
      color: Color.fromARGB(255, 34, 102, 141),
      fontWeight: FontWeight.bold,
      fontSize: 20);
  @override
  void initState() {
    super.initState();
    initReview();
  }

  Future<void> initReview() async {
    Review? current =
        await ambilDataReview(widget.kereta.kode!, widget.user.id!);
    setState(() {
      kaloada = current;
    });
  }

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
                "For: ${widget.kereta.nama}",
                style: const TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 34, 102, 141),
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            kaloada != null
                ? Card(
                    child: Slidable(
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            flex: 1,
                            onPressed: _navigateToMyReview,
                            backgroundColor: Color.fromARGB(255, 34, 102, 141),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: 'Update',
                          ),
                          SlidableAction(
                            onPressed: DeleteReview,
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
                                  widget.user.fullName.toString(),
                                  style: textKeren,
                                ),
                                const SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  "${kaloada!.rekomendasi}%",
                                  style: textKeren,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              kaloada!.content.toString()!,
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
                : Center(
                    child: Column(
                      children: [
                        Text(
                          "Masih Belum Ada Review dari Anda!",
                          style: TextStyle(
                              color: Color.fromARGB(255, 34, 102, 141),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        TextButton(
                            onPressed: () {
                              _navigateToMyReview(context);
                            },
                            child: Text("Buat Review baru?"))
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _navigateToMyReview(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TulisReview(
          kereta: widget.kereta,
          user: widget.user,
          idReview: kaloada == null ? null : kaloada!.id,
        ),
      ),
    );
  }

  void DeleteReview(BuildContext context) async {
    try {
      await ReviewClient.destroy(kaloada!.id);
      await Future.delayed(Duration.zero);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyReview(
            kereta: widget.kereta,
            user: widget.user,
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<Review?> ambilDataReview(String idKereta, int idUser) async {
    try {
      Review ThisReview =
          await ReviewClient.fetchByKeretaUser(idKereta, idUser);
      return ThisReview;
    } catch (e) {
      return null;
    }
  }
}
