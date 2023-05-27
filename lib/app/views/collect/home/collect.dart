import 'package:after_layout/after_layout.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triples_gacha/app/repositories/inventory_repo.dart';
import '../../../utils/hero_dialog_route.dart';
import '../../shop/new_objekt.dart';
import '../topbar/topbar.dart';
import '../bottombar/bottombar.dart';
import '../collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Collect extends StatefulWidget {
  const Collect({super.key});

  @override
  State<Collect> createState() => _CollectState();
}

class _CollectState extends State<Collect> with AfterLayoutMixin<Collect> {
  @override
  void afterFirstLayout(BuildContext context) async {
    dynamic obj;
    bool welcomeObj = true;
    final controller = context.read<InventoryRepo>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      welcomeObj = true;
      await prefs.setBool('isFirstLaunch', false);
    } else {
      welcomeObj = false;
    }
    if (welcomeObj) {
      obj = await controller.gacha(true);
      Navigator.of(context).push(HeroDialogRoute(builder: (context) {
        return NewObjekt(message: 'Welcome! \u{1F4AB}', card: obj);
      }));
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
