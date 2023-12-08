import 'package:flutter/material.dart';
import 'package:transportasi_11/data/client/userClient.dart';
import 'package:transportasi_11/data/review.dart';
import 'package:transportasi_11/data/user.dart';

class KeretaReviewCard extends StatefulWidget {
  final Review onereview;
  const KeretaReviewCard({super.key, required this.onereview});

  @override
  State<KeretaReviewCard> createState() => _KeretaReviewCardState();
}

class _KeretaReviewCardState extends State<KeretaReviewCard> {
  late Future<User?> _userFuture;
  Future<User?> findUser(Review thisone) async {
    try {
      User thisOne = await userClient.find(thisone.id_user);
      return thisOne;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _userFuture = findUser(widget.onereview);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textKeren = const TextStyle(
        color: Color.fromARGB(255, 34, 102, 141),
        fontWeight: FontWeight.bold,
        fontSize: 20);
    return FutureBuilder(
      future: Future.wait([_userFuture]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          User? user = snapshot.data![0] as User?;
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        user!.fullName.toString(),
                        style: textKeren,
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      Text(
                        "${widget.onereview.rekomendasi}%",
                        style: textKeren,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.onereview.content,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 34, 102, 141),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
