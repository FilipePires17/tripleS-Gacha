import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:triples_gacha/controler/controller.dart';
import 'package:triples_gacha/repositories/inventory_repo.dart';
import 'package:triples_gacha/views/shop/shop.dart';
import './views/collect/collect.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => InventoryRepo()),
    ChangeNotifierProvider(create: (_) => ComoController())
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    rechargeComo();
  }

  rechargeComo() async {
    final t = DateTime.now();
    Directory dir = await getApplicationDocumentsDirectory();
    var box = await Hive.openBox('daily', path: dir.path);
    String yesterday = box.get('day') ?? '';
    String year = t.year.toString();
    String month = t.month.toString();
    String day = t.day.toString();
    String today = '$year-$month-$day';
    if (yesterday != today) {
      Provider.of<ComoController>(context, listen: false).addComo();
      box.put('day', today);
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: Typography.blackCupertino,
          fontFamily: 'Pretendard',
          useMaterial3: true,
          colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: Color(0xFF090909),
              onPrimary: Color(0xFF090909),
              secondary: Color(0xFF8B63E7),
              onSecondary: Color(0xFF6D2BFF),
              error: Color(0xFFED1C24),
              onError: Color(0xFFED1C24),
              background: Color(0xFFFCFCFC),
              onBackground: Color(0xFFFCFCFC),
              tertiary: Color(0xFFACB5BA),
              onTertiary: Color(0xFF84898D),
              primaryContainer: Color(0xFFF2F6F9),
              surface: Color(0xFFE9ECEF),
              onSurface: Color(0xFFF2F6F9))),
      home: Collect(),
      routes: {'shop': (BuildContext ctx) => Shop()},
    );
  }
}
