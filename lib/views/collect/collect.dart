import 'package:after_layout/after_layout.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../utils/hero_dialog_route.dart';
import '../../utils/utils.dart';
import '../shop/new_objekt.dart';
import './topbar.dart';
import './bottombar.dart';
import './collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Collect extends StatefulWidget {
  const Collect({super.key});

  @override
  State<Collect> createState() => _CollectState();
}

class _CollectState extends State<Collect> with AfterLayoutMixin<Collect> {
  bool welcomeObj = true;
  Utils util = Utils();
  dynamic obj;

  @override
  void afterFirstLayout(BuildContext context) async {
    await _checkFirstLaunch();
    if (welcomeObj) {
      Navigator.of(context).push(HeroDialogRoute(builder: (context) {
        return NewObjekt(message: 'Welcome! \u{1F4AB}', card: obj);
      }));
    }
  }

  Future _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      welcomeObj = true;
      await prefs.setBool('isFirstLaunch', false);
      obj = await util.gacha(context, true);
    } else {
      welcomeObj = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(children: [TopBar(), Collection(), BottomBar()])),
    );
  }
}
