import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triples_gacha/app/features/home/data/inventory_repo.dart';

import 'app.dart';
import 'features/como/data/como_repository.dart';

class MyProvider extends StatelessWidget {
  const MyProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => InventoryRepo()),
      ChangeNotifierProvider(create: (_) => ComoRepository()),
    ], child: MyApp());
  }
}
