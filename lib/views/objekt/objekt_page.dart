import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:triples_gacha/models/inventory_objekt.dart';
import 'package:triples_gacha/views/objekt/objekt.dart';
import 'package:triples_gacha/views/objekt/warning.dart';
import '../../utils/hero_dialog_route.dart';

class ObjektPage extends StatefulWidget {
  final InventoryObjekt card;
  ObjektPage({required this.card});

  @override
  State<ObjektPage> createState() => _ObjektPageState();
}

bool backside = false;

class _ObjektPageState extends State<ObjektPage> {
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
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        SystemChrome.setSystemUIOverlayStyle(
                            SystemUiOverlayStyle(
                                statusBarColor: Colors.white,
                                statusBarIconBrightness: Brightness.dark));
                        backside = false;
                        Navigator.pop(context, false);
                      },
                      child: Container(
                        height: 0.08 * itemWidth,
                        width: 0.08 * itemWidth,
                        color: Color.fromRGBO(0, 0, 0, 0),
                        child: Center(
                          child: SizedBox(
                              height: 0.042 * itemWidth,
                              width: 0.05 * itemWidth,
                              child: Image.asset(
                                'assets\\images\\back-arrow.png',
                                fit: BoxFit.contain,
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      height: 1,
                      width: double.infinity,
                    )),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        if (await Navigator.of(context)
                            .push(HeroDialogRoute(builder: (context) {
                          return Warning();
                        }))) {
                          backside = false;
                          Navigator.pop(context, true);
                        }
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
                      'Touch Objekt to flip',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        GestureDetector(
            onTap: () {
              setState(() {
                backside = !backside;
              });
            },
            child: Flipable(
              card: widget.card,
              backside: backside,
            )),
      ]),
    ));
  }
}

class Flipable extends StatelessWidget {
  final InventoryObjekt card;
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

class Backside extends StatelessWidget {
  final InventoryObjekt card;
  const Backside({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          imageUrl: card.backside,
          errorWidget: (context, url, error) {
            return Image.asset('assets/images/${card.s}.png');
          },
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
