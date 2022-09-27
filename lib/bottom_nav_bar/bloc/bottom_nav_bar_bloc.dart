import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:simple_state_management_example/entity/models/product.dart';

part 'bottom_nav_bar_event.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  final PizzaRepository _pizzaRepository;
  late final StreamSubscription<CartStorageStatus> _homePageStatusSubscription;
  BottomNavBarBloc(this._pizzaRepository) : super(BottomNavBarState.initial()) {
    _homePageStatusSubscription =
        _pizzaRepository.cartStorageStatus.listen((status) {
      add(CartStatusChangedEvent(status));
    });
    on<LoadDataEvent>(_loadData);
    on<CartStatusChangedEvent>(_onCartStatusChanged);
    on<AddProductToCartEvent>(_addProductToCart);
    on<RemoveProductFromCartEvent>(_removeProductFromCart);
    on<ClearProductCartEvent>(_clearProductCart);
    add(LoadDataEvent());
  }

  Future<void> _onCartStatusChanged(
    CartStatusChangedEvent event,
    Emitter<BottomNavBarState> emit,
  ) async {
    switch (event.status) {
      case CartStorageStatus.empty:
        return emit(state.copyWith(
          shoppingCart: [],
          status: event.status,
        ),);
      case CartStorageStatus.loading:
        return emit(state.copyWith(status: event.status));
      case CartStorageStatus.hasData:
        final cartProducts = (await _pizzaRepository.productsCart)
            .map<Product>((e) => Product(e.name))
            .toList();
        return emit(state.copyWith(
          shoppingCart: cartProducts,
          status: event.status,
        ),);
    }
  }

  Future<void> _loadData(
    LoadDataEvent event,
    Emitter<BottomNavBarState> emit,
  ) async {
    final allProducts = (await _pizzaRepository.allProducts)
        .map<Product>((e) => Product(e.name))
        .toList();
    return emit(state.copyWith(allProducts: allProducts));
  }

  Future<void> _addProductToCart(
    AddProductToCartEvent event,
    Emitter<BottomNavBarState> emit,
  ) async {
    await _pizzaRepository.addProductToCart(event.product.name);
    final shoppingCart = (await _pizzaRepository.productsCart)
        .map<Product>((e) => Product(e.name))
        .toList();
    return emit(state.copyWith(shoppingCart: shoppingCart));
  }

  Future<void> _removeProductFromCart(
    RemoveProductFromCartEvent event,
    Emitter<BottomNavBarState> emit,
  ) async {
    await _pizzaRepository.removeProductFromCart(event.product.name);
    final shoppingCart = (await _pizzaRepository.productsCart)
        .map<Product>((e) => Product(e.name))
        .toList();
    return emit(state.copyWith(shoppingCart: shoppingCart));
  }

  Future<void> _clearProductCart(
    ClearProductCartEvent event,
    Emitter<BottomNavBarState> emit,
  ) async {
    await _pizzaRepository.removeAllProducts();
    return emit(state.copyWith(shoppingCart: []));
  }

  void dispose() {
    _homePageStatusSubscription.cancel();
    _pizzaRepository.dispose();
  }
}
