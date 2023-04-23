import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    return Container(
      width: itemWidth,
      height: itemWidth * 0.2222,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets\\images\\bottom-bar.png'),
              fit: BoxFit.fill),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: theme.colorScheme.tertiary.withOpacity(0.25),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3))
          ]),
    );
  }
}
