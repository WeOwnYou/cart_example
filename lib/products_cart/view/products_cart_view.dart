import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:simple_state_management_example/bottom_nav_bar/bloc/bottom_nav_bar_bloc.dart';
import 'package:simple_state_management_example/entity/models/product.dart';
import 'package:simple_state_management_example/products_cart/bloc/products_cart_bloc.dart';

Map<Product, int> compact(List<Product> products) {
  final result = <Product, int>{};
  for (var i = 0; i < products.length; i++) {
    result.update(
      products[i],
      (value) => value,
      ifAbsent: () =>
          products.where((element) => element == products[i]).length,
    );
  }
  return result;
}

class ProductsCartView extends StatelessWidget implements AutoRouteWrapper {
  const ProductsCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select<ProductCartBloc, CartStorageStatus>(
      (bloc) => bloc.state.status,
    );
    final productCart = context.select<ProductCartBloc, List<Product>>(
      (bloc) => bloc.state.shoppingCart,
    );
    final productCartMap = compact(productCart);
    if (status == CartStorageStatus.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (status == CartStorageStatus.error) {
      return const Scaffold(
        body: Center(
          child: Text('Unexpected error'),
        ),
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ProductCartBloc>().add(ClearProductCartEvent());
          // context.read<BottomNavBarBloc>().add(CartEntriesRemoved());
        },
        child: const Icon(Icons.delete),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: productCartMap.entries.map(
            (product) {
              return Card(
                color: Colors.green,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.key.name),
                      Text(product.value.toString()),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<ProductCartBloc>()
                              .add(RemoveProductFromCartEvent(product.key));
                          context
                              .read<BottomNavBarBloc>();
                        },
                        child: const Icon(
                          Icons.minimize,
                          color: Colors.grey,
                        ),
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Colors.deepOrange,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ProductCartBloc>(
      create: (ctx) => ProductCartBloc(context.read<PizzaRepository>()),
      child: this,
    );
  }
}
