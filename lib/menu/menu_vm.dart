import 'package:flutter/material.dart';
import 'package:pizza_repository/pizza_repository.dart';

///Provider for skillBox
// class MenuVm extends ChangeNotifier {
//   final PizzaRepository _pizzaRepository;
//   final List<String> _allProducts = [];
//   List<String> _productCart = [];
//   bool _isLoading = true;
//
//   List<String> get allProducts => _allProducts;
//   List<String> get productCart => _productCart;
//   bool get isLoading => _isLoading;
//
//   MenuVm(this._pizzaRepository) {
//     _loadData();
//   }
//
//   Future<void> _loadData() async {
//     _allProducts.addAll(await _pizzaRepository.allProducts);
//     _productCart = await _pizzaRepository.productsCart;
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   Future<void> addProduct(String product) async {
//     await _pizzaRepository.addProductToCart(product);
//     _productCart = await _pizzaRepository.productsCart;
//     notifyListeners();
//   }
//
//   Future<void> removeProduct(int index) async {
//     await _pizzaRepository.removeProductFromCart(index);
//     _productCart = await _pizzaRepository.productsCart;
//     notifyListeners();
//   }
//
//   Future<void> removeAll() async {
//     await _pizzaRepository.removeAllProducts();
//     _productCart = await _pizzaRepository.productsCart;
//     notifyListeners();
//   }
// }
