import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triples_gacha/repositories/inventory_repo.dart';
import 'package:triples_gacha/views/collect/filter.dart';
import '../../utils/utils.dart';
import 'member_filter.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    final double itemWidth = size.width;
    return Container(
      width: double.infinity,
      height: itemWidth * 0.388889,
      color: theme.colorScheme.background,
      child: Padding(
        padding:
            EdgeInsets.only(left: itemWidth * 0.055, right: 0.065 * itemWidth),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    'COLLECT',
                    style: TextStyle(
                        fontFamily: 'HalvarBreit',
                        fontSize: 20,
                        color: theme.colorScheme.primary),
                  )),
                  Padding(
                    padding: EdgeInsets.only(right: itemWidth * 0.041),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'shop');
                      },
                      child: SizedBox(
                        height: 0.047 * itemWidth,
                        width: 0.047 * itemWidth,
                        child: Image.asset(
                          'assets\\images\\shopping-bag.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Como()
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  MemberFilterButton(),
                  Expanded(
                      child: SizedBox(
                          height: 0.041 * itemWidth,
                          width: 0.041 * itemWidth,
                          child: Image.asset('assets\\images\\filter.png')))
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: Consumer<InventoryRepo>(
                    builder: (context, repo, child) {
                      var qnt = repo.cards.length;
                      return Text(
                        '$qnt items',
                        style: TextStyle(color: theme.colorScheme.primary),
                      );
                    },
                  )),
                  FilterButton()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
