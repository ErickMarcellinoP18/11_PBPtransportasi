import 'package:flutter/material.dart';

class GridExpandable extends StatefulWidget {
  const GridExpandable({super.key});

  @override
  State<GridExpandable> createState() => _GridExpandableState();
}

class _GridExpandableState extends State<GridExpandable> {
  static const itemCount = 8;

//list of each bloc expandable state, that is changed to trigger the animation of the AnimatedContainer
  List<bool> expandableState = List.generate(itemCount, (index) => false);
  Widget bloc(double width, int index) {
    bool isExpanded = expandableState[index];

    return GestureDetector(
      onTap: () {
        setState(() {
          //changing the current expandableState
          expandableState[index] = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: const EdgeInsets.all(20.0),
        width: !isExpanded ? width * 0.4 : width * 0.8,
        height: !isExpanded ? width * 0.4 : width * 0.8,
        color: Color.fromARGB(255, 82, 59, 216),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 100;

    return Scaffold(
      body: Align(
        child: SingleChildScrollView(
          child: Wrap(
            children: List.generate(itemCount, (index) {
              return bloc(width, index);
            }),
          ),
        ),
      ),
    );
  }
}
