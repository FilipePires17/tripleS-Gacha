import 'package:after_layout/after_layout.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triples_gacha/app/features/home/data/inventory_repo.dart';
import '../../../utils/hero_dialog_route.dart';
import '../../shop/presentation/new_objekt.dart';
import 'topbar.dart';
import 'bottombar.dart';
import '../../collection/presentation/collection.dart';
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
    final nav = Navigator.of(context);
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      welcomeObj = true;
      await prefs.setBool('isFirstLaunch', false);
    } else {
      welcomeObj = false;
    }
    if (welcomeObj) {
      obj = await controller.gacha(true);
      nav.push(HeroDialogRoute(builder: (context) {
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
