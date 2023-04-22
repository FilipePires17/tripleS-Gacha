import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:triples_gacha/controler/controller.dart';
import 'package:triples_gacha/repositories/inventory_repo.dart';

class Warning extends StatelessWidget {
  final int id;
  const Warning({required this.id});

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
                'Are you sure about that?',
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
          Row(
            children: [
              Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: theme.colorScheme.background,
                  ),
                  height: 0.2 * itemWidth - 2,
                  width: (0.911 * itemWidth / 2) - 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Pretendard',
                          fontSize: 18,
                          decoration: TextDecoration.none,
                          color: theme.colorScheme.tertiary),
                    ),
                  )),
              Container(
                color: Color(0xFFE9ECEF),
                height: 0.2 * itemWidth - 2,
                width: 2,
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
                  width: (0.911 * itemWidth / 2) - 1,
                  child: Consumer<InventoryRepo>(
                    builder: (context, repo, child) {
                      return GestureDetector(
                        onTap: () {
                          int count = 0;
                          SystemChrome.setSystemUIOverlayStyle(
                              SystemUiOverlayStyle(
                                  statusBarColor: Colors.white,
                                  statusBarIconBrightness: Brightness.dark));
                          Navigator.popUntil(context, (_) => count++ >= 2);
                          repo.deleteInventory(
                              inv: repo.cards
                                  .firstWhere((element) => element.id == id));
                          Provider.of<ComoController>(context, listen: false)
                              .addComo(add: 0.5);
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
                      );
                    },
                  )),
            ],
          ),
        ]),
      ),
    );
  }
}
