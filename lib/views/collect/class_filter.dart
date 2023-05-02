import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triples_gacha/models/inventory_objekt.dart';
import 'package:triples_gacha/repositories/inventory_repo.dart';

List<bool> isButtonPressed = [false, false, false, false];
String query = '';

class ClassFilter extends StatefulWidget {
  const ClassFilter({super.key});

  @override
  State<ClassFilter> createState() => _ClassFilterState();
}

class _ClassFilterState extends State<ClassFilter> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    final double itemWidth = size.width;
    return Container(
      decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: itemWidth * 0.03),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  height: itemWidth * 0.01481,
                  width: itemWidth * 0.1204,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 0.08333 * itemWidth, top: itemWidth * 0.02),
              child: Text(
                'Class',
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 0.08333 * itemWidth, top: itemWidth * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClassButon(
                    classOption: 'w',
                    buttonIndex: 0,
                  ),
                  SizedBox(
                    width: itemWidth * 2 * 0.03241,
                  ),
                  ClassButon(
                    classOption: 'f',
                    buttonIndex: 1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: itemWidth * 0.03241,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.08333 * itemWidth),
              child: Row(
                children: [
                  ClassButon(
                    classOption: 's',
                    buttonIndex: 2,
                  ),
                  SizedBox(
                    width: itemWidth * 2 * 0.03241,
                  ),
                  ClassButon(
                    classOption: 'd',
                    buttonIndex: 3,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: itemWidth * 0.03241,
                bottom: itemWidth * 0.03241,
              ),
              child: Container(
                height: 2,
                width: double.infinity,
                color: Color.fromARGB(255, 220, 225, 228),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 0.08333 * itemWidth,
                  right: 0.08333 * itemWidth,
                  bottom: 0.06333 * itemWidth),
              child: Row(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        isButtonPressed.setAll(0, [false, false, false, false]);
                      });
                      query = '';
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: theme.colorScheme.surfaceVariant,
                      ),
                      height: itemWidth * 0.1296,
                      width: itemWidth * 0.2546,
                      alignment: Alignment.center,
                      child: Text(
                        'Clear',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: itemWidth * 0.03241,
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Provider.of<InventoryRepo>(context, listen: false)
                            .orderByClass(query == '' ? 'wsfd' : query);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: theme.colorScheme.onSecondary,
                        ),
                        alignment: Alignment.center,
                        height: itemWidth * 0.1296,
                        child: Text(
                          'Apply',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}

class ClassButon extends StatefulWidget {
  final String classOption;
  final int buttonIndex;
  ClassButon({super.key, required this.classOption, required this.buttonIndex});

  @override
  State<ClassButon> createState() => _ClassButonState();
}

class _ClassButonState extends State<ClassButon> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> classes = {
      'f': 'First',
      's': 'Special',
      'd': 'Double',
      'w': 'Welcome'
    };
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    final double itemWidth = size.width;
    return Center(
      child: GestureDetector(
        onTap: () {
          if (isButtonPressed[widget.buttonIndex]) {
            setState(() {
              isButtonPressed[widget.buttonIndex] =
                  !isButtonPressed[widget.buttonIndex];
            });
            query = query.replaceAll(widget.classOption, '');
          } else {
            setState(() {
              isButtonPressed[widget.buttonIndex] =
                  !isButtonPressed[widget.buttonIndex];
            });
            query = '${widget.classOption}$query';
          }
          print(query);
        },
        child: Container(
          padding: EdgeInsets.only(
              left: 0.03704 * itemWidth, right: 0.03704 * itemWidth),
          alignment: Alignment.center,
          height: itemWidth * 0.06296,
          //width: itemWidth * 0.1852,
          decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.onSurface),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: isButtonPressed[widget.buttonIndex]
                  ? theme.colorScheme.onSecondary
                  : theme.colorScheme.primaryContainer),
          child: Text(
            classes[widget.classOption]!,
            style: TextStyle(
                fontSize: 14,
                color: isButtonPressed.contains(true)
                    ? Colors.white
                    : Colors.grey),
          ),
        ),
      ),
    );
  }
}
