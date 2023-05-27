import 'package:flutter/material.dart';

class NoComo extends StatelessWidget {
  const NoComo({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    var theme = Theme.of(context);
    return Center(
      child: Container(
        width: 0.911 * itemWidth,
        height: itemWidth * 0.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: theme.colorScheme.background),
        child: Column(children: [
          SizedBox(
            height: itemWidth * 0.3,
            child: Center(
              child: Text(
                "You don't have enough points! \u{1F622}",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Pretendard',
                    fontSize: 20,
                    decoration: TextDecoration.none,
                    color: Color(0xFF080809)),
              ),
            ),
          ),
          Container(
            color: Color(0xFFE9ECEF),
            height: 2,
            width: double.infinity,
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: theme.colorScheme.background,
            ),
            height: 0.2 * itemWidth - 2,
            width: double.infinity,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Pretendard',
                    fontSize: 18,
                    decoration: TextDecoration.none,
                    color: theme.colorScheme.secondary),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
