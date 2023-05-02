import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    return Container(
      width: itemWidth,
      height: itemWidth * 0.2222,
      decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.25),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 3))
          ]),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: SizedBox(
                  height: itemWidth * 0.07,
                  child: Image.asset(
                    'assets/images/casa.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                'Σigma',
                style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontFamily: 'Pretendard-Light',
                    decoration: TextDecoration.none,
                    fontSize: 12),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: SizedBox(
                  height: itemWidth * 0.07,
                  child: Image.asset(
                    'assets/images/Ativo_24x.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                'Stan',
                style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontFamily: 'Pretendard-Light',
                    decoration: TextDecoration.none,
                    fontSize: 12),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Container(
                  height: itemWidth * 0.125,
                  width: itemWidth * 0.125,
                  decoration: BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                  child: Center(
                    child: SizedBox(
                      height: itemWidth * 0.07,
                      child: Image.asset(
                        'assets/images/capturar.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  height: itemWidth * 0.055,
                  child: Image.asset('assets/images/Ativo_54x.png'),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: SizedBox(
                  height: itemWidth * 0.07,
                  child: Image.asset(
                    'assets/images/Ativo_34x.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                'Gravity',
                style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontFamily: 'Pretendard-Light',
                    decoration: TextDecoration.none,
                    fontSize: 12),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: SizedBox(
                  height: itemWidth * 0.07,
                  child: Image.asset(
                    'assets/images/Ativo_44x.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                'My',
                style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontFamily: 'Pretendard-Light',
                    decoration: TextDecoration.none,
                    fontSize: 12),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
