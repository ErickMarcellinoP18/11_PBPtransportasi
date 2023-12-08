import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transportasi_11/client/ReviewClient.dart';
import 'package:transportasi_11/data/client/userClient.dart';
import 'package:transportasi_11/data/kereta.dart';
import 'package:transportasi_11/data/review.dart';

import 'package:transportasi_11/data/user.dart';

import 'package:transportasi_11/view/Reviews/reviewKeretaCard.dart';

import 'package:sensors_plus/sensors_plus.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/services.dart';

class ReviewKereta extends ConsumerWidget {
  final String idKereta;
  late final FutureProvider<List<Review>> listReviewProvider;
  ReviewKereta({Key? key, required this.idKereta}) : super(key: key) {
    listReviewProvider = FutureProvider<List<Review>>((ref) async {
      return await ReviewClient.fetchByKereta(idKereta);
    });
  }

  double _brightnessValue = 0.1; // Kecerahan awal (0-1)
  double _initialBrightness = 0.5; // Kecerahan awal yang disimpan
  ScreenBrightness screenBrightness = ScreenBrightness();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listener = ref.watch(listReviewProvider);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 206, 205, 205),
      appBar: AppBar(
        leading: IconButton(
            color: const Color.fromARGB(255, 255, 250, 221),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Color.fromARGB(255, 34, 102, 141),
        title: Text(
          "History",
          style: TextStyle(color: Color.fromARGB(255, 255, 250, 221)),
        ),
      ),
      body: ListView.builder(
        itemCount: listener.when(
          data: (reviews) => reviews.length,
          loading: () => 0,
          error: (_, __) => 0,
        ),
        itemBuilder: (context, index) {
          return listener.when(
            data: (reviews) {
              final review = reviews[index];
              return Padding(
                padding: EdgeInsets.all(10),
                child: Container(child: KeretaReviewCard(onereview: review)),
              );
            },
            error: (err, s) => Center(child: Text(err.toString())),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Future<User?> findUser(Review thisone) async {
    try {
      User thisOne = await userClient.find(thisone.id_user);
      return thisOne;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
