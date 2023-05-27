import 'package:flutter/material.dart';
import '../../models/inventory_objekt.dart';
import '../objekt/objekt.dart';

class NewObjekt extends StatelessWidget {
  final String message;
  final InventoryObjekt card;

  NewObjekt({required this.message, required this.card});

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
      child: SizedBox(
        width: 0.911 * itemWidth,
        child: AspectRatio(
          aspectRatio: 99 / 153,
          child: Container(
            width: 0.911 * itemWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: theme.colorScheme.background),
            child: Column(children: [
              Expanded(
                child: Center(
                  child: Text(
                    message,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Pretendard',
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        color: Color(0xFF080809)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 0.079 * itemWidth),
                child: SizedBox(
                    height: 0.6 * (0.911 * itemWidth / 99) * 153,
                    width: 0.6 * (0.911 * itemWidth / 99) * 100,
                    child: Objekt(card: card, wcdco: wcdco, fontSize: 15)),
              ),
              Container(
                color: Color(0xFFE9ECEF),
                height: 2,
                width: double.infinity,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: theme.colorScheme.background,
                  ),
                  height: 0.2 * itemWidth - 2,
                  width: double.infinity,
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
              )
            ]),
          ),
        ),
      ),
    );
  }
}
