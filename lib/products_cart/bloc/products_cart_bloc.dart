import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:simple_state_management_example/entity/models/product.dart';

part 'products_cart_event.dart';
part 'products_cart_state.dart';

class ProductCartBloc extends Bloc<ProductCartEvent, ProductsCartState> {
  final PizzaRepository _pizzaRepository;
  late final StreamSubscription<CartStorageStatus> _cartStatusSubscription;
  ProductCartBloc(this._pizzaRepository) : super(ProductsCartState.loading()) {
    on<CartStatusChangedEvent>(_onCartStatusChanged);
    on<RemoveProductFromCartEvent>(_removeProductFromCart);
    on<ClearProductCartEvent>(_clearProductCart);
    _cartStatusSubscription =
        _pizzaRepository.cartStorageStatus.listen((status) {
      add(CartStatusChangedEvent(status));
    });
  }

  void _onCartStatusChanged(
    CartStatusChangedEvent event,
    Emitter<ProductsCartState> emit,
  ) {
    switch (event.status) {
      case CartStorageStatus.empty:
        return emit(ProductsCartState.empty());
      case CartStorageStatus.loading:
        return emit(ProductsCartState.loading());
      case CartStorageStatus.updated:
        final cartProducts = (_pizzaRepository.productsCart)
            .map<Product>((e) => Product(e.name))
            .toList();
        return emit(ProductsCartState.data(cartProducts));
      case CartStorageStatus.error:
        return emit(ProductsCartState.error());
    }
  }

  Future<void> _removeProductFromCart(
    RemoveProductFromCartEvent event,
    Emitter<ProductsCartState> emit,
  ) async {
    await _pizzaRepository.removeProductFromCart(event.product.name);
    // final shoppingCart = (_pizzaRepository.productsCart)
    //     .map<Product>((e) => Product(e.name))
    //     .toList();
    // return emit(state.copyWith(shoppingCart: shoppingCart));
  }

  Future<void> _clearProductCart(
    ClearProductCartEvent event,
    Emitter<ProductsCartState> emit,
  ) async {
    await _pizzaRepository.removeAllProducts();
    // return emit(state.copyWith(shoppingCart: []));
  }

  void dispose() {
    _cartStatusSubscription.cancel();
    _pizzaRepository.dispose();
  }
}
