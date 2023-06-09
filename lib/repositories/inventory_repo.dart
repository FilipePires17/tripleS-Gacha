import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:triples_gacha/models/inventory_objekt.dart';

import '../database/db.dart';

class InventoryRepo extends ChangeNotifier {
  List<InventoryObjekt> _inventory = [];
  List<InventoryObjekt> _inventoryTemp = [];

  List<String> order = ['Newest', 'Oldest', 'Highest No.', 'Lowest No.'];
  String _currentOrder = 'Newest';

  get currentOrder => _currentOrder;

  UnmodifiableListView<InventoryObjekt> get cards =>
      UnmodifiableListView<InventoryObjekt>(_inventoryTemp);

  int _member = 0;
  int get member => _member;

  modelFromId(db, objId) async {
    List objQuery = await db.rawQuery('''SELECT objekts.*, backside.urlb 
        FROM objekts
        INNER JOIN backside ON objekts.backside_id = backside.id
        WHERE objekts.id = $objId; ''');
    return objQuery[0];
  }

  void addInventory({required InventoryObjekt inv}) async {
    var db = await DB.get();
    int id = await db.insert('inventory', {
      'serial': inv.serial,
      'obj_id': inv.objId,
      'created': inv.date.toString()
    });
    inv.id = id;
    _inventory.add(inv);
    _inventoryTemp.add(inv);
    orderByDate(true);
    _currentOrder = order[0];
    notifyListeners();
  }

  void deleteInventory({required InventoryObjekt inv}) async {
    var db = await DB.get();
    int count =
        await db.delete('inventory', where: 'id = ?', whereArgs: [inv.id]);
    _inventory.remove(inv);
    _inventoryTemp.remove(inv);
    assert(count == 1);
    notifyListeners();
  }

  InventoryRepo() {
    initRepository();
  }

  filterRepository(int s) async {
    _inventoryTemp.clear();

    for (var o in _inventory) {
      if (o.s == s.toString() || s == 0) {
        _inventoryTemp.add(o);
      }
    }
    _member = s;
    maintainOrder();
  }

  initRepository() async {
    var db = await DB.get();
    List invObjs = await db.rawQuery('''
    SELECT inventory.*, objekts.class_num, objekts.s, objekts.url, objekts.class, backside.urlb
    FROM inventory 
    INNER JOIN objekts ON inventory.obj_id = objekts.id
    INNER JOIN backside ON objekts.backside_id = backside.id
    ORDER BY created DESC;
    ''');

    for (var o in invObjs) {
      var invObj = InventoryObjekt(
          id: o['id'],
          objId: o['obj_id'],
          serial: o['serial'],
          url: o['url'],
          backside: o['urlb'],
          classId: o['class_num'],
          objektClass: o['class'],
          s: o['s'],
          date: DateTime.parse(o['created']));
      _inventory.add(invObj);
      _inventoryTemp.add(invObj);
    }
    orderByDate(true);
    print('initRepository:');
    print(_inventory);
  }

  orderByDate(bool byNewest) {
    if (!byNewest) {
      _inventoryTemp.sort((InventoryObjekt inv1, InventoryObjekt inv2) =>
          inv1.date.compareTo(inv2.date));
      _currentOrder = order[1];
    } else {
      _inventoryTemp.sort((InventoryObjekt inv1, InventoryObjekt inv2) =>
          inv2.date.compareTo(inv1.date));
      _currentOrder = order[0];
    }
    notifyListeners();
  }

  orderByNumber(bool byHighest) {
    if (!byHighest) {
      _inventoryTemp.sort((InventoryObjekt inv1, InventoryObjekt inv2) =>
          inv1.classId.compareTo(inv2.classId));
      _currentOrder = order[3];
    } else {
      _inventoryTemp.sort((InventoryObjekt inv1, InventoryObjekt inv2) =>
          inv2.classId.compareTo(inv1.classId));
      _currentOrder = order[2];
    }
    notifyListeners();
  }

  // orderByClass(String query) {
  //   //_inventoryTemp.clear();

  //   for (var i in _inventory) {
  //     if (!i.objektClass.contains(RegExp('[$query]co'))) {
  //       _inventoryTemp.remove(i);
  //     }
  //   }
  //   maintainOrder();
  // }

  maintainOrder() {
    if (_currentOrder == order[0]) {
      orderByDate(true);
    } else if (_currentOrder == order[1]) {
      orderByDate(false);
    } else if (_currentOrder == order[2]) {
      orderByNumber(true);
    } else {
      orderByNumber(false);
    }
  }

  maintainFilter({int s = -1}) {
    filterRepository(s == -1 ? _member : s);
    apply();
  }

  //---------------------------------------------------------------------

  List<bool> _isButtonPressed = [false, false, false, false];
  List<String> _classOption = ['w', 'f', 's', 'd'];
  String _query = '';
  bool _isApplied = false;

  UnmodifiableListView<bool> get isButtonPressed =>
      UnmodifiableListView<bool>(_isButtonPressed);

  UnmodifiableListView<String> get classOption =>
      UnmodifiableListView<String>(_classOption);

  String get query => _query;

  bool get isApplied => _isApplied;

  pressButton(int index) {
    if (isButtonPressed[index]) {
      _isButtonPressed[index] = !_isButtonPressed[index];
      _query = _query.replaceAll(_classOption[index], '');
    } else {
      _isButtonPressed[index] = !_isButtonPressed[index];
      _query = '${_classOption[index]}$_query';
    }
    print(_query);
    notifyListeners();
  }

  clear() {
    _isButtonPressed.setAll(0, [false, false, false, false]);
    _query = '';
    notifyListeners();
  }

  apply() {
    _isApplied = _query != ''; // ? false : true;
    //orderByClass(_query == '' ? 'wsfd' : _query);
    var query = _query == '' ? 'wsfd' : _query;
    for (var i in _inventory) {
      if (!i.objektClass.contains(RegExp('[$query]co'))) {
        _inventoryTemp.remove(i);
      }
    }
    maintainOrder();
  }
}
