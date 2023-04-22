import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triples_gacha/repositories/inventory_repo.dart';
import 'dart:math' as math;

import 'package:triples_gacha/utils/utils.dart';

import '../../utils/hero_dialog_route.dart';

class MemberFilterButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MemberFilterButton();
  }
}

List<String> urls = [
  'https://live.staticflickr.com/65535/52827356851_e04ce6ac9a_n.jpg',
  'https://live.staticflickr.com/65535/52827494649_37fc872f7a_z.jpg',
  'https://live.staticflickr.com/65535/52827323766_23d8992a50_n.jpg',
  'https://live.staticflickr.com/65535/52826750877_1b91c965cc_n.jpg',
  'https://live.staticflickr.com/65535/52827323841_761b7a29bd_n.jpg',
  'https://live.staticflickr.com/65535/52827763368_98d9a0a131_n.jpg',
  'https://live.staticflickr.com/65535/52827505364_bce7811554_n.jpg',
  'https://live.staticflickr.com/65535/52827724920_4c057cb855_n.jpg',
  'https://live.staticflickr.com/65535/52827323916_b1aeb1331c_n.jpg',
  'https://live.staticflickr.com/65535/52826750827_8f80ba632d_n.jpg',
  'https://live.staticflickr.com/65535/52827763273_701c475888_n.jpg'
];

List<String> options = [
  'All',
  'SeoYeon',
  'HyeRin',
  'JiWoo',
  'ChaeYeon',
  'YooYeon',
  'SooMin',
  'NaKyung',
  'YuBin',
  'Kaede',
  'DaHyun'
];

class _MemberFilterButton extends State<MemberFilterButton> {
  bool isMemberFilterPressed = false;
  // bool isDropdownActive = false;
  final GlobalKey filterKey = GlobalKey();
  //OverlayEntry? floatingDropdown;

  // OverlayEntry _createFloatingDropdown() {
  //   return OverlayEntry(
  //     builder: (BuildContext context) {
  //       //var theme = Theme.of(context);
  //       var size = MediaQuery.of(context).size;
  //       final double itemWidth = size.width;
  //       return Positioned(
  //           // You can change the position here
  //           left: filterKey.currentContext!
  //               .findRenderObject()!
  //               .getTransformTo(null)
  //               .getTranslation()[0],
  //           width: 0.754 * itemWidth,
  //           top: filterKey.currentContext!
  //                   .findRenderObject()!
  //                   .getTransformTo(null)
  //                   .getTranslation()[1] +
  //               0.125 * itemWidth,
  //           height: 0.662 * itemWidth,
  //           // Any child
  //           child: MemberFilter());
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          isMemberFilterPressed = !isMemberFilterPressed;
        });
        Navigator.of(context).push(HeroDialogRoute(
            isFilter: true,
            builder: (context) {
              return Positioned(
                  left: filterKey.currentContext!
                      .findRenderObject()!
                      .getTransformTo(null)
                      .getTranslation()[0],
                  width: 0.754 * itemWidth,
                  top: filterKey.currentContext!
                          .findRenderObject()!
                          .getTransformTo(null)
                          .getTranslation()[1] +
                      0.125 * itemWidth,
                  height: 0.662 * itemWidth,
                  // Any child
                  child: MemberFilter());
            }));
      },
      child: Container(
        key: filterKey,
        height: 0.125 * itemWidth,
        width: 0.754 * itemWidth,
        decoration: BoxDecoration(
            color: isMemberFilterPressed
                ? theme.colorScheme.surface
                : theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: theme.colorScheme.surface)),
        child: Consumer<InventoryRepo>(
          builder: (context, repo, child) {
            return Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 0.031 * itemWidth, right: 0.028 * itemWidth),
                  child: Container(
                    height: 0.083 * itemWidth,
                    width: 0.083 * itemWidth,
                    padding: EdgeInsets.all(0.005 * itemWidth),
                    decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        shape: BoxShape.circle),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size:
                            Size.fromRadius(0.074 * itemWidth), // Image radius
                        child:
                            Image.network(urls[repo.member], fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                repo.member == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'All',
                            style: TextStyle(
                                fontSize: 14,
                                color: theme.hintColor,
                                decoration: TextDecoration.none,
                                fontFamily: 'Pretendard'),
                          ),
                          Text(
                            'tripleS',
                            style: TextStyle(
                                fontSize: 11,
                                color: theme.colorScheme.onTertiary),
                          )
                        ],
                      )
                    : Text(
                        options[repo.member],
                        style: TextStyle(
                            fontSize: 14,
                            color: theme.hintColor,
                            decoration: TextDecoration.none,
                            fontFamily: 'Pretendard'),
                      ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0.041 * itemWidth, 0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 0.019 * itemWidth,
                        width: 0.029 * itemWidth,
                        child: Transform.rotate(
                          angle: isMemberFilterPressed ? math.pi : 0,
                          child: Image.asset(
                            'assets\\images\\arrow-down-grey.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class MemberFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    return Container(
      height: 0.662 * itemWidth,
      width: 0.754 * itemWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: theme.colorScheme.surface, width: 2),
        color: theme.colorScheme.background,
      ),
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.separated(
          padding: EdgeInsets.only(
              top: 0.02 * itemWidth,
              bottom: 0.02 * itemWidth,
              left: 0.032 * itemWidth),
          itemCount: options.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Provider.of<InventoryRepo>(context, listen: false)
                    .filterRepository(index);
                Navigator.pop(context);
              },
              child: Container(
                color: Color.fromRGBO(0, 0, 0, 0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 0.03 * itemWidth),
                      child: ClipOval(
                        child: SizedBox.fromSize(
                            size: Size.fromRadius(
                                0.041 * itemWidth), // Image radius
                            child: Image.network(
                              urls[index],
                              fit: BoxFit.cover,
                            )
                            // Image.asset('assets\\images\\tripleS_logo.png',
                            //     fit: BoxFit.cover),
                            ),
                      ),
                    ),
                    Text(options[index],
                        style: TextStyle(
                            fontSize: 14,
                            color: theme.hintColor,
                            decoration: TextDecoration.none,
                            fontFamily: 'Pretendard')),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: double.infinity,
              height: 0.04 * itemWidth,
            );
          },
        ),
      ),
    );
  }
}

class FilterButton extends StatefulWidget {
  FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool isFilterPressed = false;
  bool isDropdownActive = false;
  final GlobalKey filterKey2 = GlobalKey();
  OverlayEntry? floatingDropdown;

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(
      builder: (BuildContext context) {
        var size = MediaQuery.of(context).size;
        final double itemWidth = size.width;
        return Positioned(
            // You can change the position here
            right: filterKey2.currentContext!
                    .findRenderObject()!
                    .getTransformTo(null)
                    .getTranslation()[2] +
                0.035 * itemWidth,
            width: 0.374 * itemWidth,
            top: filterKey2.currentContext!
                    .findRenderObject()!
                    .getTransformTo(null)
                    .getTranslation()[1] +
                0.059 * itemWidth,
            height: 0.426 * itemWidth,
            // Any child
            child: Filter());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          isFilterPressed = !isFilterPressed;
          if (isDropdownActive) {
            floatingDropdown?.remove();
            floatingDropdown = null;
          } else {
            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context).insert(floatingDropdown!);
          }

          isDropdownActive = !isDropdownActive;
        });
      },
      child: Container(
        key: filterKey2,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 0.025 * itemWidth),
              child: Consumer<InventoryRepo>(
                builder: (context, repo, child) {
                  return Text(repo.currentOrder,
                      style: TextStyle(color: theme.colorScheme.primary));
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
    return Container(
      height: 0.426 * itemWidth,
      width: 0.374 * itemWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        border: Border.all(color: theme.colorScheme.surface, width: 2),
        color: theme.colorScheme.background,
      ),
      padding: EdgeInsets.only(top: 0.06 * itemWidth, bottom: 0.06 * itemWidth),
      child: Consumer<InventoryRepo>(
        builder: (context, repo, child) => Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  repo.orderByDate(true);
                },
                child: Text('Newest',
                    style: TextStyle(
                        fontSize: 14,
                        color: theme.hintColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'Pretendard')),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  repo.orderByDate(false);
                },
                child: Text('Oldest',
                    style: TextStyle(
                        fontSize: 14,
                        color: theme.hintColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'Pretendard')),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  repo.orderByNumber(false);
                },
                child: Text('Lowest No.',
                    style: TextStyle(
                        fontSize: 14,
                        color: theme.hintColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'Pretendard')),
              ),
            ),
            GestureDetector(
              onTap: () {
                repo.orderByNumber(true);
              },
              child: Text('Highest No.',
                  style: TextStyle(
                      fontSize: 14,
                      color: theme.hintColor,
                      decoration: TextDecoration.none,
                      fontFamily: 'Pretendard')),
            ),
          ],
        ),
      ),
    );
  }
}
