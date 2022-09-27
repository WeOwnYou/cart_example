import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:simple_state_management_example/bottom_nav_bar/bloc/bottom_nav_bar_bloc.dart';
import 'package:simple_state_management_example/navigation/router.dart';

class BottomNavBarView extends StatelessWidget implements AutoRouteWrapper {
  const BottomNavBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        MenuRoute(),
        ProductsCartRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        final cartProductsCount = context.select<BottomNavBarBloc, int>(
          (bloc) => bloc.state.shoppingCart.length,
        );
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            const BottomNavigationBarItem(
              label: 'Menu',
              icon: Icon(Icons.calendar_month),
            ),
            BottomNavigationBarItem(
              label: 'Cart',
              icon: Badge(
                showBadge: cartProductsCount != 0,
                badgeContent: Text(cartProductsCount.toString()),
                child: const Icon(Icons.shopping_cart_rounded),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<BottomNavBarBloc>(
      create: (ctx) => BottomNavBarBloc(PizzaRepository()),
      child: this,
    );
  }
}
