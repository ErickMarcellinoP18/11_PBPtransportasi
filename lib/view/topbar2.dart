import 'package:flutter/material.dart';

class topBar extends StatefulWidget {
  const topBar({super.key});

  @override
  State<topBar> createState() => _topBarState();
}

class _topBarState extends State<topBar> {
  final upperTab = const TabBar(tabs: <Tab>[
    Tab(
      icon: Icon(Icons.person),
    ),
    Tab(
      icon: Icon(Icons.person),
    ),
    Tab(
      icon: Icon(Icons.person),
    ),
    Tab(
      icon: Icon(Icons.person),
    ),
    Tab(
      icon: Icon(Icons.person),
    )
  ]);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: upperTab,
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text("Joshua Puniwan Yahya"),
            ),
            Center(
              child: Text("Tio Pramudya"),
            ),
            Center(
              child: Text("Erick Marcellino Pranata"),
            ),
            Center(
              child: Text("Agatha Andrea Situngkir"),
            ),
            Center(
              child: Text("Samuel Juang"),
            )
          ],
        ),
      ),
    );
    ;
  }
}
