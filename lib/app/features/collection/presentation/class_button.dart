import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/data/inventory_repo.dart';

class ClassButon extends StatefulWidget {
  final int buttonIndex;
  ClassButon({super.key, required this.buttonIndex});

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
      child: Consumer<InventoryRepo>(
        builder: (context, repo, child) {
          return GestureDetector(
            onTap: () {
              repo.pressButton(widget.buttonIndex);
            },
            child: Container(
              padding: EdgeInsets.only(
                  left: 0.03704 * itemWidth, right: 0.03704 * itemWidth),
              alignment: Alignment.center,
              height: itemWidth * 0.06296,
              decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.onSurface),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: repo.isButtonPressed[widget.buttonIndex]
                      ? theme.colorScheme.onSecondary
                      : theme.colorScheme.primaryContainer),
              child: Text(
                classes[repo.classOption[widget.buttonIndex]]!,
                style: TextStyle(
                    fontSize: 14,
                    color: repo.isButtonPressed[widget.buttonIndex]
                        ? Colors.white
                        : Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}
