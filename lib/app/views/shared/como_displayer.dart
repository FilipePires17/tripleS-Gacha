import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/como_controller.dart';

class ComoDisplayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    final double itemWidth = size.width;
    return Container(
        height: itemWidth * 0.0625,
        width: itemWidth * 0.16,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(itemWidth * 0.0625 / 2)),
            color: theme.colorScheme.primaryContainer),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0.015 * itemWidth),
              child: SizedBox(
                height: 0.032 * itemWidth,
                width: 0.032 * itemWidth,
                child: Image.asset(
                  'assets\\images\\como.png',
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Consumer<ComoController>(
                builder: (context, como, child) {
                  var c = como.como.floor().toString();
                  return Text(
                    c,
                    style: TextStyle(
                        fontSize: 11, color: theme.colorScheme.primary),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
