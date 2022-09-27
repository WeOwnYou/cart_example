import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pizza_repository/src/hive_provider.dart';

import 'models/models.dart';

enum CartStorageStatus { empty, loading, updated, error }

class PizzaRepository {
  final _controller = StreamController<CartStorageStatus>.broadcast();
  final List<Product> _productsCart = [];
  late Box<Product> _productsBox;

  Stream<CartStorageStatus> get cartStorageStatus async* {
    var hasError = false;
    try {
      await _init();
    } on Exception {
      hasError = true;
    }
    if (hasError) {
      yield CartStorageStatus.error;
    } else if (_productsCart.isEmpty) {
      yield CartStorageStatus.empty;
    } else {
      yield CartStorageStatus.updated;
    }
    yield* _controller.stream;
  }

  Future<void> _init() async {
    _productsBox = await HiveProvider.instance.openProductsCartBox();
    if (_productsCart.isNotEmpty) {
      _productsCart.map((e) async {
        await _productsBox.add(e);
        await _productsBox.compact();
      });
    } else {
      _productsCart.addAll(_productsBox.values.toList());
    }
  }

  List<Product> get allProducts {
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

  List<Product> get productsCart {
    return _productsCart;
  }

  Future<void> addProductToCart(String productName) async {
    final product = _stringToProduct(productName);
    _productsCart.add(product);
    await _productsBox.add(product);
    await _productsBox.compact();
    _controller.add(CartStorageStatus.updated);
  }

  Future<void> removeProductFromCart(String productName) async {
    final product = _stringToProduct(productName);
    if (_productsCart.isEmpty) return;
    await _productsBox
        .deleteAt(_productsCart.indexOf(product)); //совпадают индексы?
    await _productsBox.compact();
    _productsCart.remove(product);
    _controller.add(CartStorageStatus.updated);
  }

  Future<void> removeProductAt(int index) async {
    if (_productsCart.isEmpty) return;
    _productsCart.removeAt(index);
    await _productsBox.deleteAt(index);
    await _productsBox.compact();
    _controller.add(CartStorageStatus.updated);
  }

  Future<void> removeAllProducts() async {
    if (_productsCart.isEmpty) return;
    await _productsBox.clear();
    _productsCart.clear();
    _controller.add(CartStorageStatus.updated);
  }

  void dispose() => _controller.close();
}
