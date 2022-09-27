import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pizza_repository/src/models/models.dart';

class HiveProvider {
  HiveProvider._();
  static final HiveProvider instance = HiveProvider._();

  Future<Box<Product>> openProductsCartBox() async {
    const boxName = 'products_cart';
    if (!Hive.isAdapterRegistered(ProductAdapter().typeId)) {
      Hive.registerAdapter(ProductAdapter());
    }
    return Hive.isBoxOpen(boxName)
        ? Hive.box<Product>(boxName)
        : await Hive.openBox<Product>(boxName);
  }

  void closeBox(Box<dynamic> box) {
    box
      ..compact()
      ..close();
  }
}
