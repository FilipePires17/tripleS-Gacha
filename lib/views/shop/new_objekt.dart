import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:triples_gacha/models/inventory_objekt.dart';

class NewObjekt extends StatelessWidget {
  final String message;
  final InventoryObjekt card;

  NewObjekt({required this.message, required this.card});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    var theme = Theme.of(context);
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
                child: Container(
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                card.url.trimLeft()))),
                    height: 0.6 * (0.911 * itemWidth / 99) * 153,
                    width: 0.6 * (0.911 * itemWidth / 99) * 100,
                    child: Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: RotatedBox(
                            quarterTurns: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${card.classId.toString()}Z',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none),
                                ),
                                Text(
                                  card.serial.toString().length == 1
                                      ? '#0000${card.serial.toString()}'
                                      : '#000${card.serial.toString()}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.red,
                                      fontFamily: 'Dot-matrix',
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none),
                                ),
                              ],
                            )))),
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
              )
            ]),
          ),
        ),
      ),
    );
  }
}
