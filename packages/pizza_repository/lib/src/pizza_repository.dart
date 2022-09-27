import 'models/models.dart';

class PizzaRepository {
  final List<Product> _productsCart = [];
  Product _stringToProduct(String name)=>Product(name);
  Future<List<Product>> get allProducts async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final allProducts = <Product>[
      ...pizzas.map(_stringToProduct),
      ...combo.map(_stringToProduct),
      ...snacks.map(_stringToProduct),
      ...deserts.map(_stringToProduct),
      ...drinks.map(_stringToProduct),
    ];
    return allProducts;
  }

  Future<void> addProductToCart(String product) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _productsCart.add(_stringToProduct(product));
  }

  Future<void> removeProductFromCart(String product) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _productsCart.remove(_stringToProduct(product));
  }

  Future<void> removeProductAt(int index) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _productsCart.removeAt(index);
  }

  Future<void> removeAllProducts() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _productsCart.clear();
  }

  Future<List<Product>> get productsCart async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return _productsCart;
  }
}
