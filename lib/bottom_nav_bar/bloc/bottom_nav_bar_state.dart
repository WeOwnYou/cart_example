part of 'bottom_nav_bar_bloc.dart';

class BottomNavBarState {
  final List<Product> shoppingCart;
  final List<Product> allProducts;
  BottomNavBarState._(this.shoppingCart, this.allProducts);
  BottomNavBarState.initial() : this._([], []);
  BottomNavBarState copyWith({
    List<Product>? allProducts,
    List<Product>? shoppingCart,
  }) {
    return BottomNavBarState._(
      shoppingCart ?? this.shoppingCart,
      allProducts ?? this.allProducts,
    );
  }
}
