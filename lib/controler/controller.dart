import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

class ComoController extends ChangeNotifier {
  double _como = 0;

  double get como => _como;

  ComoController() {
    updateComos();
  }

  updateComos() async {
    Directory dir = await getApplicationDocumentsDirectory();
    var box = await Hive.openBox('como', path: dir.path);
    _como = box.get('quant') ?? 5.0;
    notifyListeners();
  }

  addComo({var add = 5.0}) async {
    Directory dir = await getApplicationDocumentsDirectory();
    var box = await Hive.openBox('como', path: dir.path);
    await box.put('quant', _como + add);
    _como = box.get('quant') ?? 5.0;
    notifyListeners();
  }

  subtractComo() async {
    Directory dir = await getApplicationDocumentsDirectory();
    var box = await Hive.openBox('como', path: dir.path);
    await box.put('quant', _como - 1.0);
    _como = box.get('quant') ?? 5.0;
    notifyListeners();
  }
}
