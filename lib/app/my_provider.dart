import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triples_gacha/app/repositories/inventory_repo.dart';
import 'package:triples_gacha/app/utils/utils.dart';

import 'app.dart';
import 'controller/como_controller.dart';

class MyProvider extends StatelessWidget {
  const MyProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => InventoryRepo()),
      ChangeNotifierProvider(create: (_) => ComoController()),
    ], child: MyApp());
  }
}
