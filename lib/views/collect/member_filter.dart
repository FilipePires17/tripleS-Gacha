import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triples_gacha/repositories/inventory_repo.dart';
import 'dart:math' as math;

import 'package:triples_gacha/utils/utils.dart';

import '../../utils/hero_dialog_route.dart';

bool isMemberFilterPressed = false;

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
  @override
  void initState() {
    bool isCurrent = true;
    super.initState();
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      isCurrent = ModalRoute.of(context)?.isCurrent ?? false;
      if (isCurrent) {
        setState(() {
          isMemberFilterPressed = false;
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
          isMemberFilterPressed = !isMemberFilterPressed;
        });
        Navigator.of(context).push(
            HeroDialogRoute(isFilter: true, builder: (ctx) => MemberFilter()));
      },
      child: Container(
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
                        size: Size.fromRadius(0.074 * itemWidth),
                        child: CachedNetworkImage(
                          imageUrl: urls[repo.member],
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return Image.asset(
                                'assets/images/tripleS_logo.png');
                          },
                        ),
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
    final double unsafeArea = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(
          left: itemWidth * 0.055,
          top: (itemWidth * 0.388889 * 2 / 3) +
              unsafeArea -
              (itemWidth * 0.003)),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
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
                  behavior: HitTestBehavior.opaque,
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
                                size: Size.fromRadius(0.041 * itemWidth),
                                child: CachedNetworkImage(
                                    imageUrl: urls[index],
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) {
                                      return Image.asset(
                                          'assets/images/tripleS_logo.png');
                                    })),
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
        ),
      ),
    );
  }
}
