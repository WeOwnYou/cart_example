import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:simple_state_management_example/bottom_nav_bar/view/bottom_nav_bar_view.dart';
import 'package:simple_state_management_example/menu/view/menu_view.dart';
import 'package:simple_state_management_example/products_cart/view/products_cart_view.dart';

part 'router.gr.dart';

abstract class Routes {
  static const bottomNavBar = 'bottom_nav_bar_screen';
  static const menuPage = 'menu_page';
  static const cartPage = 'cart_page';
}

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: [
    AutoRoute<void>(
      path: Routes.bottomNavBar,
      initial: true,
      page: BottomNavBarView,
      children: [
        AutoRoute<void>(
          path: Routes.menuPage,
          initial: true,
          page: MenuView,
        ),
        AutoRoute<void>(
          path: Routes.cartPage,
          page: ProductsCartView,
        )
      ],
    ),
  ],
)
class AppRouter extends _$AppRouter {
  static final AppRouter _router = AppRouter._();

  AppRouter._();

  factory AppRouter.instance() => _router;
}
