import 'package:flutter/material.dart';

class inputHome extends StatefulWidget {
  const inputHome({super.key});

  @override
  State<inputHome> createState() => _inputHomeState();
}

class _inputHomeState extends State<inputHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: constraints.maxHeight * .4,
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/download.jpeg")),
              Container(
                height: constraints.maxHeight, // will get by column
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
