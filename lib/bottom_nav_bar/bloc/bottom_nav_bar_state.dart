part of 'bottom_nav_bar_bloc.dart';

class BottomNavBarState {
  final List<Product> shoppingCart;
  final List<Product> allProducts;
  final CartStorageStatus status;
  BottomNavBarState._(
      {required this.shoppingCart,
      required this.allProducts,
      required this.status,});
  BottomNavBarState.initial()
      : this._(
          shoppingCart: [],
          allProducts: [],
          status: CartStorageStatus.loading,
        );
  BottomNavBarState copyWith({
    List<Product>? allProducts,
    List<Product>? shoppingCart,
    CartStorageStatus? status,
  }) {
    return BottomNavBarState._(
      shoppingCart: shoppingCart ?? this.shoppingCart,
      allProducts: allProducts ?? this.allProducts,
      status: status ?? this.status,
    );
  }
}
