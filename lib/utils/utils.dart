import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:triples_gacha/controler/controller.dart';

import '../database/db.dart';
import '../models/inventory_objekt.dart';
import '../repositories/inventory_repo.dart';

class Utils {
  Future<InventoryObjekt> gacha(BuildContext context, bool welcome) async {
    var db = await DB.get();
    int rate = Random().nextInt(500);
    int intValue;
    if (rate == 499) {
      intValue = 545;
    } else if (rate >= 490 || welcome) {
      intValue = Random().nextInt(10) + 1;
    } else if (rate > 150) {
      intValue = Random().nextInt(200) + 11;
    } else {
      intValue = Random().nextInt(334) + 211;
    }
    final date = DateTime.now();
    var obj = await Provider.of<InventoryRepo>(context, listen: false)
        .modelFromId(db, intValue);

    Directory dir = await getApplicationDocumentsDirectory();
    var box = await Hive.openBox('serial', path: dir.path);
    var s = obj['s'];
    var classId = obj['class_num'];
    var getSerial = box.get('$s-$classId') ?? 0;
    box.put('$s-$classId', getSerial + 1);

    InventoryObjekt inv = InventoryObjekt(
        id: 0,
        serial: getSerial + 1,
        objId: intValue,
        url: obj['url'],
        backside: obj['urlb'],
        classId: classId,
        objektClass: obj['class'],
        s: s,
        date: date);
    Provider.of<InventoryRepo>(context, listen: false).addInventory(inv: inv);
    return inv;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class Como extends StatelessWidget {
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
