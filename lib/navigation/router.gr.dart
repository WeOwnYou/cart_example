// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    BottomNavBarRoute.name: (routeData) {
      return MaterialPageX<void>(
        routeData: routeData,
        child: WrappedRoute(child: const BottomNavBarView()),
      );
    },
    MenuRoute.name: (routeData) {
      return MaterialPageX<void>(
        routeData: routeData,
        child: const MenuView(),
      );
    },
    ProductsCartRoute.name: (routeData) {
      return MaterialPageX<void>(
        routeData: routeData,
        child: const ProductsCartView(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: 'bottom_nav_bar_screen',
          fullMatch: true,
        ),
        RouteConfig(
          BottomNavBarRoute.name,
          path: 'bottom_nav_bar_screen',
          children: [
            RouteConfig(
              '#redirect',
              path: '',
              parent: BottomNavBarRoute.name,
              redirectTo: 'menu_page',
              fullMatch: true,
            ),
            RouteConfig(
              MenuRoute.name,
              path: 'menu_page',
              parent: BottomNavBarRoute.name,
            ),
            RouteConfig(
              ProductsCartRoute.name,
              path: 'cart_page',
              parent: BottomNavBarRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [BottomNavBarView]
class BottomNavBarRoute extends PageRouteInfo<void> {
  const BottomNavBarRoute({List<PageRouteInfo>? children})
      : super(
          BottomNavBarRoute.name,
          path: 'bottom_nav_bar_screen',
          initialChildren: children,
        );

  static const String name = 'BottomNavBarRoute';
}

/// generated route for
/// [MenuView]
class MenuRoute extends PageRouteInfo<void> {
  const MenuRoute()
      : super(
          MenuRoute.name,
          path: 'menu_page',
        );

  static const String name = 'MenuRoute';
}

/// generated route for
/// [ProductsCartView]
class ProductsCartRoute extends PageRouteInfo<void> {
  const ProductsCartRoute()
      : super(
          ProductsCartRoute.name,
          path: 'cart_page',
        );

  static const String name = 'ProductsCartRoute';
}
