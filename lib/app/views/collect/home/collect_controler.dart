import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repositories/inventory_repo.dart';

class CollectController {
  bool welcomeObj = true;
  Future _checkFirstLaunch(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      welcomeObj = true;
      await prefs.setBool('isFirstLaunch', false);
    } else {
      welcomeObj = false;
    }
  }
}
