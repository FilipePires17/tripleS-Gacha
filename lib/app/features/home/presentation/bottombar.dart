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
      decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.25),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 3))
          ]),
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          'assets/images/bottom-bar.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
