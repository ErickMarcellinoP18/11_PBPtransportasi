import 'dart:io';

import 'package:flutter/material.dart';
import 'package:transportasi_11/data/ticket.dart';

class OrderHistCard extends StatelessWidget {
  final ticket tic;
  const OrderHistCard({super.key, required this.tic});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        height: 200,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Container(
                width: 200,
                child: Center(
                  child: Icon(Icons.ac_unit),
                ),
              ),
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      height: 50,
                      child: Text(
                        tic.asal!,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Divider(
                    thickness: 50,
                    color: Theme.of(context).colorScheme.primary,
                    indent: BorderSide.strokeAlignCenter,
                  ),
                  Container(
                    child: Text(tic.tujuan!),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class CardHistList extends StatefulWidget {
//   const CardHistList({super.key});
//   @override
//   State<CardHistList> createState() => _CardHistListState();
// }

// class _CardHistListState extends State<CardHistList> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: CardHistList.listString?.length,
//       itemBuilder: (BuildContext context, index) {
//         return OrderHistCard(
//             word: CardHistList.listString![index],
//             desc: CardHistList.listDesc![index],
//             icon: Icon(
//               Icons.airline_seat_flat_angled,
//               size: 100.0,
//             ));
//       },
//     );
//   }
// }
