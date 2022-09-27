part of 'bottom_nav_bar_bloc.dart';

class BottomNavBarState {
  final List<Product> allProducts;
  int? productsInCart;
  BottomNavBarState._({
    required this.allProducts,
    this.productsInCart,
  });
  BottomNavBarState.initial()
      : this._(
          allProducts: [],
        );

  BottomNavBarState copyWith({
    List<Product>? allProducts,
    int? productsInCart,
  }) {
    return BottomNavBarState._(
      allProducts: allProducts ?? this.allProducts,
      productsInCart: productsInCart ?? this.productsInCart,
    );
  }
}
