import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triples_gacha/repositories/inventory_repo.dart';
import 'package:triples_gacha/utils/hero_dialog_route.dart';

class FilterButton extends StatefulWidget {
  FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool isFilterPressed = false;

  @override
  void initState() {
    bool isCurrent;
    super.initState();
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      isCurrent = ModalRoute.of(context)?.isCurrent ?? false;
      if (isCurrent) {
        setState(() {
          isFilterPressed = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          isFilterPressed = !isFilterPressed;
        });
        Navigator.push(
            context,
            HeroDialogRoute(
                isFilter: true,
                builder: (context) {
                  return Filter();
                }));
      },
      child: SizedBox(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 0.025 * itemWidth),
              child: Consumer<InventoryRepo>(
                builder: (context, repo, child) {
                  return Text(repo.currentOrder,
                      style: TextStyle(
                          color: theme.colorScheme.primary, fontSize: 12));
                },
              ),
            ),
            SizedBox(
                height: 0.015 * itemWidth,
                width: 0.025 * itemWidth,
                child: Transform.rotate(
                  angle: isFilterPressed ? math.pi : 0,
                  child: Image.asset(
                    'assets\\images\\arrow-down-black.png',
                    fit: BoxFit.fill,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class Filter extends StatelessWidget {
  Filter({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    final double unsafeArea = MediaQuery.of(context).padding.top;
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(
            top: (itemWidth * 0.388889) + unsafeArea - (itemWidth * 0.012),
            right: itemWidth * 0.032),
        child: Container(
          height: 0.426 * itemWidth,
          width: 0.374 * itemWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: theme.colorScheme.surface, width: 2),
            color: theme.colorScheme.background,
          ),
          padding:
              EdgeInsets.only(top: 0.06 * itemWidth, bottom: 0.06 * itemWidth),
          child: Consumer<InventoryRepo>(
            builder: (context, repo, child) => Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      repo.orderByDate(true);
                      Navigator.pop(context);
                    },
                    child: Text('Newest',
                        style: TextStyle(
                            fontSize: 12,
                            color: repo.currentOrder == 'Newest'
                                ? Colors.black
                                : Colors.grey,
                            decoration: TextDecoration.none,
                            fontFamily: 'Pretendard')),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      repo.orderByDate(false);
                      Navigator.pop(context);
                    },
                    child: Text('Oldest',
                        style: TextStyle(
                            fontSize: 12,
                            color: repo.currentOrder == 'Oldest'
                                ? Colors.black
                                : Colors.grey,
                            decoration: TextDecoration.none,
                            fontFamily: 'Pretendard')),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      repo.orderByNumber(false);
                      Navigator.pop(context);
                    },
                    child: Text('Lowest No.',
                        style: TextStyle(
                            fontSize: 12,
                            color: repo.currentOrder == 'Lowest No.'
                                ? Colors.black
                                : Colors.grey,
                            decoration: TextDecoration.none,
                            fontFamily: 'Pretendard')),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    repo.orderByNumber(true);
                    Navigator.pop(context);
                  },
                  child: Text('Highest No.',
                      style: TextStyle(
                          fontSize: 12,
                          color: repo.currentOrder == 'Highest No.'
                              ? Colors.black
                              : Colors.grey,
                          decoration: TextDecoration.none,
                          fontFamily: 'Pretendard')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
