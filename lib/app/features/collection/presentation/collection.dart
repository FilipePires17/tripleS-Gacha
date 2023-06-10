import 'package:flutter/material.dart';
import '../../como/data/como_repository.dart';
import '../../objekt/domain/objekt_model.dart';
import '../../home/data/inventory_repo.dart';
import '../../../utils/utils.dart';
import 'package:provider/provider.dart';
import '../../objekt/presentation/objekt.dart';
import '../../objekt_page/presentation/objekt_page.dart';

class Collection extends StatefulWidget {
  @override
  State<Collection> createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    var theme = Theme.of(context);

    return Expanded(
      child: Container(
        color: theme.colorScheme.background,
        child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: Consumer<InventoryRepo>(builder: (context, repo, child) {
              return GridView.count(
                padding: EdgeInsets.fromLTRB(
                    itemWidth * 0.05, 0.0, itemWidth * 0.05, itemWidth * 0.07),
                crossAxisCount: 3,
                mainAxisSpacing: itemWidth * 0.0416,
                crossAxisSpacing: itemWidth * 0.025,
                childAspectRatio: (1000 / 1545),
                children: List.generate(repo.cards.length, (index) {
                  final List<ObjektModel> cards = repo.cards;
                  ObjektModel card = cards[index];
                  bool wcdco = false;
                  if (card.classId.trimLeft() == '317' ||
                      card.classId.trimLeft() == '318' ||
                      card.classId.trimLeft() == '319' ||
                      card.classId.trimLeft() == '329') wcdco = true;
                  //print(card.url);
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Objekt(card: card, wcdco: wcdco, fontSize: 7),
                    onTap: () {
                      Future pageResolve = Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ObjektPage(card: card)));
                      pageResolve.then((value) {
                        if (value) {
                          repo.deleteInventory(
                              inv: repo.cards.firstWhere(
                                  (element) => element.id == card.id));
                          Provider.of<ComoRepository>(context, listen: false)
                              .addComo(add: 0.5);
                        }
                      });
                    },
                  );
                }),
              );
            })),
      ),
    );
  }
}
