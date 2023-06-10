import 'package:flutter/material.dart';

import '../domain/objekt_model.dart';
import 'objekt.dart';

class Flipable extends StatelessWidget {
  final ObjektModel card;
  final bool backside;
  const Flipable({super.key, required this.card, required this.backside});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    var theme = Theme.of(context);
    bool wcdco = false;
    if (card.classId.trimLeft() == '317' ||
        card.classId.trimLeft() == '318' ||
        card.classId.trimLeft() == '319' ||
        card.classId.trimLeft() == '329') wcdco = true;
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                  color: theme.colorScheme.onTertiary.withOpacity(0.5),
                  spreadRadius: 1.5,
                  blurRadius: 5,
                  offset: Offset(0, 5))
            ]),
        height: 1.16 * itemWidth,
        width: 0.759 * itemWidth,
        child: AspectRatio(
          aspectRatio: (1000 / 1545),
          child: backside
              ? Backside(
                  card: card,
                )
              : Objekt(card: card, wcdco: wcdco, fontSize: 18),
        ),
      ),
    );
  }
}
