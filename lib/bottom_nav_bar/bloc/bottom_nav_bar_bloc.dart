import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:simple_state_management_example/entity/models/product.dart';

part 'bottom_nav_bar_event.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  final PizzaRepository _pizzaRepository;
  late final StreamSubscription<CartStorageStatus> _cartStatusSubscription;
  BottomNavBarBloc(this._pizzaRepository) : super(BottomNavBarState.initial()) {
    _cartStatusSubscription =
        _pizzaRepository.cartStorageStatus.listen((status) {
      add(CartStatusChangedEvent(status));
    });
    on<CartStatusChangedEvent>(_onCartStatusChanged);
    on<LoadDataEvent>(_loadData);
    on<AddProductToCartEvent>(_addProductToCart);
    add(LoadDataEvent());
  }

  void _onCartStatusChanged(
    CartStatusChangedEvent event,
    Emitter<BottomNavBarState> emit,
  ) {
    switch (event.status) {
      case CartStorageStatus.empty:
      case CartStorageStatus.loading:
      case CartStorageStatus.updated:
      return emit(state.copyWith(
        productsInCart: _pizzaRepository.productsCart.length,),);
      case CartStorageStatus.error:
        return;
    }
  }

  Future<void> _loadData(
    LoadDataEvent event,
    Emitter<BottomNavBarState> emit,
  ) async {
    final allProducts = (_pizzaRepository.allProducts)
        .map<Product>((e) => Product(e.name))
        .toList();
    return emit(
      state.copyWith(
        allProducts: allProducts,
        productsInCart: _pizzaRepository.productsCart.length,
      ),
    );
  }

  Future<void> _addProductToCart(
    AddProductToCartEvent event,
    Emitter<BottomNavBarState> emit,
  ) async {
    await _pizzaRepository.addProductToCart(event.product.name);
  }

  void dispose() {
    _cartStatusSubscription.cancel();
    _pizzaRepository.dispose();
  }
}
