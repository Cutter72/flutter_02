import 'package:flutter/material.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ChartBar extends StatelessWidget {
  final double percent; // 0-1

  ChartBar(this.percent);


  @override
  Widget build(BuildContext context) {
    return Text("${(percent*100).toStringAsFixed(0)}%");
  }

}
