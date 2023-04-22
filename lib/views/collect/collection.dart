import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:triples_gacha/models/inventory_objekt.dart';
import 'package:triples_gacha/repositories/inventory_repo.dart';
import 'package:triples_gacha/views/objekt/objekt_page.dart';
import '../../utils/utils.dart';
import 'package:provider/provider.dart';
//import 'package:get/get.dart';

class Collection extends StatefulWidget {
  @override
  State<Collection> createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    //final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width;
    var theme = Theme.of(context);

    return Expanded(
      child: Container(
        color: theme.colorScheme.background,
        child: Padding(
          padding:
              EdgeInsets.fromLTRB(itemWidth * 0.04, 0.0, itemWidth * 0.04, 0.0),
          child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: Consumer<InventoryRepo>(builder: (context, repo, child) {
                return GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: itemWidth * 0.04,
                  crossAxisSpacing: itemWidth * 0.022,
                  childAspectRatio: (1000 / 1545),
                  children: List.generate(repo.cards.length, (index) {
                    final List<InventoryObjekt> cards = repo.cards;
                    InventoryObjekt card = cards[index];
                    print(card.url);
                    return GestureDetector(
                      child: Container(
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    card.url.trimLeft()))),
                        child: Padding(
                            padding: EdgeInsets.only(right: 2),
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
                                          fontSize: 7,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      card.serial.toString().length == 1
                                          ? '#0000${card.serial.toString()}'
                                          : '#000${card.serial.toString()}',
                                      style: TextStyle(
                                          fontSize: 7,
                                          color: Colors.red,
                                          fontFamily: 'Dot-matrix',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ))),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ObjektPage(id: card.id)));
                      },
                    );
                  }),
                );
              })),
        ),
      ),
    );
  }
}
