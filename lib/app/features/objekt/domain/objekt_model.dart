
class ObjektModel {
  int id;
  int objId;
  int serial;
  String url;
  String backside;
  String classId;
  String objektClass;
  String s;
  DateTime date;

  ObjektModel(
      {this.id = 0,
      required this.objId,
      required this.serial,
      required this.url,
      required this.backside,
      required this.classId,
      required this.objektClass,
      required this.s,
      required this.date});
}
