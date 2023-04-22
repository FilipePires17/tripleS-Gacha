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
    List objQuery =
        await db.rawQuery('SELECT * FROM objekts WHERE objekts.id = $objId');
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
    orderByDate(true);
  }

  initRepository() async {
    var db = await DB.get(); // explicar que aqui irá iniciar o DB
    List invObjs = await db.rawQuery('''
    SELECT inventory.*, objekts.class_num, objekts.s, objekts.url, objekts.class
    FROM inventory 
    INNER JOIN objekts ON inventory.obj_id = objekts.id
    ORDER BY created DESC;
    ''');

    for (var o in invObjs) {
      var invObj = InventoryObjekt(
          id: o['id'],
          objId: o['obj_id'],
          serial: o['serial'],
          url: o['url'],
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
}
