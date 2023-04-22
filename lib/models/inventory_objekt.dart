class InventoryObjekt {
  int id;
  int objId;
  int serial;
  String url;
  String classId;
  String objektClass;
  String s;
  DateTime date;

  InventoryObjekt(
      {this.id = 0,
      required this.objId,
      required this.serial,
      required this.url,
      required this.classId,
      required this.objektClass,
      required this.s,
      required this.date});
}
