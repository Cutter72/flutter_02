import 'package:flutter/material.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ChartBar extends StatelessWidget {
  final double percent; // 0-1

  ChartBar(this.percent);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 60,
            width: 10,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 1,
            )),
          ),
          Container(
            height: percent * 60,
            width: 10,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
