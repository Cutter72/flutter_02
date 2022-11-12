import 'package:flutter/material.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ChartBar extends StatelessWidget {
  final double percent; // 0-1

  ChartBar(this.percent);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (buildContext , boxConstraints ) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: boxConstraints.maxHeight,
              width: 10,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 1,
                  )),
            ),
            Container(
              height: boxConstraints.maxHeight * percent,
              width: 10,
              color: Theme.of(context).primaryColor,
            ),
          ],
        );
      },
    );
  }
}
