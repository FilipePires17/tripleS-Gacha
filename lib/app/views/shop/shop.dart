import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triples_gacha/app/repositories/inventory_repo.dart';
import 'package:triples_gacha/app/views/shared/como_displayer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/como_controller.dart';
import '../../models/inventory_objekt.dart';
import '../../utils/hero_dialog_route.dart';
import '../../utils/utils.dart';
import 'copyright.dart';
import 'new_objekt.dart';
import 'nocomo.dart';

class Shop extends StatelessWidget {
  const Shop({super.key});

  Future<String> _lerArquivoTexto(BuildContext context) async {
    return await DefaultAssetBundle.of(context)
        .loadString('assets\\texts\\shop_disclaimer.txt');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: theme.colorScheme.background,
              height: 0.13 * itemWidth,
              width: double.infinity,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 0.065 * itemWidth,
                        right: itemWidth * 0.1 - 0.023 * itemWidth),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        width: 0.1 * itemWidth,
                        height: 0.08 * itemWidth,
                        child: Center(
                          child: SizedBox(
                              height: 0.042 * itemWidth,
                              width: 0.1 * itemWidth,
                              child: Image.asset(
                                'assets\\images\\back-arrow.png',
                                fit: BoxFit.contain,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text('SHOP',
                          style: TextStyle(
                              fontFamily: 'HalvarBreit', fontSize: 20)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 0.065 * itemWidth),
                    child: ComoDisplayer(),
                  )
                ],
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: theme.colorScheme.background,
                      height: 0.88 * itemWidth,
                      width: double.infinity,
                      child: Image.asset('assets\\images\\packet.png'),
                    ),
                    SizedBox(
                      height: 0.116 * itemWidth,
                      width: double.infinity,
                      child: Row(children: [
                        Expanded(
                          child: Container(
                            color: Color(0xFF7D8A93),
                            height: 0.116 * itemWidth,
                            child: Center(
                              child: Text('tripleS Atom01 Objekt',
                                  style: TextStyle(
                                      fontFamily: 'HalvarBreit',
                                      fontSize: 16,
                                      color: theme.colorScheme.background)),
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xFF49565C),
                          height: 0.116 * itemWidth,
                          width: 0.3 * itemWidth,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('USD ',
                                    style: TextStyle(
                                        fontFamily: 'HalvarBreit',
                                        fontSize: 16,
                                        color: Color(0xFFD0D7DF))),
                                Text('2.99',
                                    style: TextStyle(
                                        fontFamily: 'HalvarBreit',
                                        fontSize: 16,
                                        color: theme.colorScheme.background))
                              ]),
                        ),
                      ]),
                    ),
                    Container(
                      padding: EdgeInsets.all(0.065 * itemWidth),
                      color: theme.colorScheme.background,
                      height: 800,
                      child: DefaultTextStyle(
                        style: theme.textTheme.displayMedium!,
                        child: FutureBuilder<String>(
                          future: _lerArquivoTexto(context),
                          builder: (context, snapshot) {
                            Widget child;
                            if (snapshot.hasData) {
                              child = Text(
                                snapshot.data!,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: theme.colorScheme.primary),
                              );
                            } else {
                              child = Text('?');
                            }
                            return child;
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              Uri url = Uri.parse(
                                  'https://play.google.com/store/apps/details?id=com.modhaus.cosmo');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 40),
                              child: Text(
                                'Cosmo: The Origin',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 40),
                            child: Text('  ·  '),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.of(context).push(HeroDialogRoute(
                                  builder: (context) => Copyright()));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 40),
                              child: Text(
                                'Credits',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  border: Border(
                      top: BorderSide(color: Color(0xFFECECEC), width: 2))),
              height: 0.2 * itemWidth,
              width: double.infinity,
              child: Center(
                child: Consumer<InventoryRepo>(
                  builder: (context, repo, child) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        var c =
                            Provider.of<ComoController>(context, listen: false)
                                .como;
                        if (c >= 1) {
                          Provider.of<ComoController>(context, listen: false)
                              .subtractComo();
                          InventoryObjekt obj = await repo.gacha(false);
                          Navigator.of(context)
                              .push(HeroDialogRoute(builder: (context) {
                            return NewObjekt(
                                message: 'Loaded into Cosmo! \u{1F4AB}',
                                card: obj);
                          }));
                        } else {
                          Navigator.of(context)
                              .push(HeroDialogRoute(builder: (context) {
                            return NoComo();
                          }));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 0.116 * itemWidth,
                        width: 0.87 * itemWidth,
                        decoration: BoxDecoration(
                            color: theme.colorScheme.onSecondary,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          'Objekt Purchase',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
