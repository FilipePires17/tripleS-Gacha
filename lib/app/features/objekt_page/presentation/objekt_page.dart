import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:triples_gacha/app/features/delete_objekt/presentation/warning.dart';
import '../../objekt/domain/objekt_model.dart';
import '../../../utils/hero_dialog_route.dart';
import '../../objekt/presentation/flippable.dart';

class ObjektPage extends StatefulWidget {
  final ObjektModel card;
  ObjektPage({required this.card});

  @override
  State<ObjektPage> createState() => _ObjektPageState();
}

class _ObjektPageState extends State<ObjektPage> {
  late bool backside;

  @override
  void initState() {
    super.initState();
    backside = false;
  }

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
                      onTap: () {
                        Future pageResolve = Navigator.of(context).push(
                            HeroDialogRoute(builder: (context) => Warning()));
                        pageResolve.then((value) {
                          if (value) {
                            backside = false;
                            Navigator.pop(context, true);
                          }
                        });
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
              if (widget.card.s != '0') {
                setState(() {
                  backside = !backside;
                });
              }
            },
            child: Flipable(
              card: widget.card,
              backside: backside,
            )),
      ]),
    ));
  }
}
