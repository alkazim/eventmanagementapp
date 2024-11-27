import 'package:flutter/material.dart';

class Mydesignswedding extends StatelessWidget {
  const Mydesignswedding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Center(
            child: Text(
              "My Designs",
              style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF3d466b),
                  fontFamily: 'Cinzel',
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
        backgroundColor: Color(0xFFf0ecff), // appBar color
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color(0xFFf0ecff),

    );
  }
}
