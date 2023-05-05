import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:triples_gacha/models/inventory_objekt.dart';

class Objekt extends StatelessWidget {
  final InventoryObjekt card;
  final bool wcdco;
  final double fontSize;
  const Objekt(
      {super.key,
      required this.card,
      required this.wcdco,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: CachedNetworkImage(
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          imageUrl: card.url.trimLeft(),
          errorWidget: (context, url, error) {
            return Center(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Image.asset(
                  card.s != '0'
                      ? 'assets/images/${card.s}.png'
                      : 'assets/images/zero.png',
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
          fit: BoxFit.fill,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: EdgeInsets.only(right: fontSize * 0.35),
            child: RotatedBox(
                quarterTurns: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${card.classId.toString()}Z',
                      style: TextStyle(
                          fontSize: fontSize,
                          color: wcdco ? Colors.purple : Colors.red,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none),
                    ),
                    Text(
                      card.serial.toString().length == 1
                          ? '#0000${card.serial.toString()}'
                          : '#000${card.serial.toString()}',
                      style: TextStyle(
                          fontSize: fontSize,
                          color: wcdco ? Colors.purple : Colors.red,
                          fontFamily: 'Dot-matrix',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none),
                    ),
                  ],
                ))),
      )
    ]);
  }
}

class Backside extends StatelessWidget {
  final InventoryObjekt card;
  const Backside({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    return Stack(
      children: [
        Center(
          child: CachedNetworkImage(
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            imageUrl: card.backside,
            errorWidget: (context, url, error) {
              return Image.asset('assets/images/${card.s}.png');
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
              padding: EdgeInsets.only(
                  right: itemWidth * 0.19, bottom: itemWidth * 0.235),
              height: itemWidth * 0.45,
              width: itemWidth * 0.403,
              child: Image.asset(
                'assets/images/myqr.png',
                fit: BoxFit.fill,
              )),
        )
      ],
    );
  }
}
