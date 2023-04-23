import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:triples_gacha/models/inventory_objekt.dart';
import 'package:triples_gacha/repositories/inventory_repo.dart';
import 'package:triples_gacha/views/objekt/warning.dart';
import '../../utils/hero_dialog_route.dart';

class ObjektPage extends StatelessWidget {
  final int id;
  ObjektPage({required this.id});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    var theme = Theme.of(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: theme.colorScheme.onSecondary,
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFFCFCFC), Color(0xFFAFB8BF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 0.033 * itemWidth,
                  left: 0.065 * itemWidth,
                  right: 0.046 * itemWidth,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        SystemChrome.setSystemUIOverlayStyle(
                            SystemUiOverlayStyle(
                                statusBarColor: Colors.white,
                                statusBarIconBrightness: Brightness.dark));
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                          height: 0.042 * itemWidth,
                          width: 0.023 * itemWidth,
                          child: Image.asset(
                            'assets\\images\\back-arrow.png',
                            fit: BoxFit.fill,
                          )),
                    ),
                    Expanded(
                        child: SizedBox(
                      height: 1,
                      width: double.infinity,
                    )),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(HeroDialogRoute(builder: (context) {
                          return Warning(
                            id: id,
                          );
                        }));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 0.109 * itemWidth,
                        width: 0.25 * itemWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Padding(
                            padding: EdgeInsets.only(right: 0.023 * itemWidth),
                            child: SizedBox(
                                height: 0.042 * itemWidth,
                                width: 0.042 * itemWidth,
                                child: Image.asset('assets\\images\\send.png')),
                          ),
                          Text(
                            'Delete',
                            style: TextStyle(fontSize: 16),
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 0.056 * itemWidth,
                    width: 0.056 * itemWidth,
                    child: Image.asset(
                      'assets\\images\\finger.png',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 0.02 * itemWidth, bottom: 0.05 * itemWidth),
                    child: Text(
                      'Touch Objekt to not flip',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Center(
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
              child: Consumer<InventoryRepo>(builder: (context, repo, child) {
                int garbage = 0;
                for (var o in repo.cards) {
                  if (o.id == id) {
                    break;
                  } else {
                    garbage++;
                  }
                }
                InventoryObjekt card = repo.cards[garbage];
                return Container(
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              CachedNetworkImageProvider(card.url.trimLeft()))),
                  child: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: RotatedBox(
                          quarterTurns: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${card.classId.toString()}Z',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                card.serial.toString().length == 1
                                    ? '#0000${card.serial.toString()}'
                                    : '#000${card.serial.toString()}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontFamily: 'Dot-matrix',
                                ),
                              ),
                            ],
                          ))),
                );
              }),
            ),
          ),
        ),
      ]),
    ));
  }
}
