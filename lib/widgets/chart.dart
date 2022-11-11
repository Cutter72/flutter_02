import 'package:flutter/material.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text("\$"),
              Text("\$"),
              Text("M"),
            ],
          )
        ],
      ),
    );
  }
}
