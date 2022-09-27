part of 'products_cart_bloc.dart';

class ProductsCartState {
  final List<Product> shoppingCart;
  final CartStorageStatus status;

  ProductsCartState._({required this.shoppingCart, required this.status});
  ProductsCartState.loading()
      : this._(shoppingCart: [], status: CartStorageStatus.loading);
  ProductsCartState.empty()
      : this._(shoppingCart: [], status: CartStorageStatus.empty);
  ProductsCartState.error()
      : this._(shoppingCart: [], status: CartStorageStatus.error);
  ProductsCartState.data(List<Product> shoppingCart)
      : this._(shoppingCart: shoppingCart, status: CartStorageStatus.updated);

  ProductsCartState copyWith({
    CartStorageStatus? status,
    List<Product>? shoppingCart,
  }) {
    return ProductsCartState._(
      shoppingCart: shoppingCart ?? this.shoppingCart,
      status: status ?? this.status,
    );
  }
}
