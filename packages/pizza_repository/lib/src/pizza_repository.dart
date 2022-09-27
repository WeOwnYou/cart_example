import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:pizza_repository/src/hive_provider.dart';

import 'models/models.dart';

enum CartStorageStatus { empty, loading, hasData }

class PizzaRepository {
  final _controller = StreamController<CartStorageStatus>();
  final List<Product> _productsCart = [];
  late final Box<Product> _productsBox;

  Stream<CartStorageStatus> get cartStorageStatus async* {
    yield CartStorageStatus.loading;
    await _init();
    if (_productsCart.isEmpty) {
      yield CartStorageStatus.empty;
    } else {
      yield CartStorageStatus.hasData;
    }
    yield* _controller.stream;
  }

  Future<void> _init() async {
    _productsBox = await HiveProvider.instance.openProductsCartBox();
    if (_productsCart.isNotEmpty) {
      _productsCart.removeRange(0, _productsCart.length);
    }
    _productsCart.addAll(_productsBox.values.toList());
  }

  Future<List<Product>> get allProducts async {
    final allProducts = <Product>[
      ...pizzas.map(_stringToProduct),
      ...combo.map(_stringToProduct),
      ...snacks.map(_stringToProduct),
      ...deserts.map(_stringToProduct),
      ...drinks.map(_stringToProduct),
    ];
    return allProducts;
  }

  Product _stringToProduct(String name) => Product(name);

  Future<List<Product>> get productsCart async {
    return _productsCart;
  }

  Future<void> addProductToCart(String productName) async {
    final product = _stringToProduct(productName);
    _productsCart.add(product);
    await _productsBox.add(product);
    await _productsBox.compact();
  }

  Future<void> removeProductFromCart(String productName) async {
    final product = _stringToProduct(productName);
    if (_productsCart.isEmpty) return;
    await _productsBox
        .deleteAt(_productsCart.indexOf(product)); //совпадают индексы?
    await _productsBox.compact();
    _productsCart.remove(product);
  }

  Future<void> removeProductAt(int index) async {
    if (_productsCart.isEmpty) return;
    _productsCart.removeAt(index);
    await _productsBox.deleteAt(index);
    await _productsBox.compact();
  }

  Future<void> removeAllProducts() async {
    if (_productsCart.isEmpty) return;
    await _productsBox.deleteFromDisk();
    _productsCart.clear();
  }

  void dispose() => _controller.close();
}
