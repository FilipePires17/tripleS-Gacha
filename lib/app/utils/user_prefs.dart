import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserPrefs {
  Future instance();
  // Future set({String setKey, setValue});
}

class UserSharedPrefs implements UserPrefs {
  // SharedPreferences shrdPrefs = SharedPreferences.;
  @override
  Future instance() {
    return SharedPreferences.getInstance();
  }

  // @override
  // Future set(String setKey, setValue) {
  //   return Future.value(1);
  // }
}

class UserHivePrefs implements UserPrefs {
  final String boxName;
  UserHivePrefs(this.boxName);

  @override
  Future instance() async {
    Directory dir = await getApplicationDocumentsDirectory();
    return Hive.openBox(boxName, path: dir.path);
  }
}
