import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_state_management_example/bottom_nav_bar/bloc/bottom_nav_bar_bloc.dart';
import 'package:simple_state_management_example/entity/models/product.dart';

Map<Product, int> compact(List<Product> products) {
  final result = <Product, int>{};
  for (var i = 0; i < products.length; i++) {
    result.update(products[i], (value) => value,
        ifAbsent: () =>
            products.where((element) => element == products[i]).length,);
  }
  return result;
}

class ProductsCartView extends StatelessWidget {
  const ProductsCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productCart = context.select<BottomNavBarBloc, List<Product>>(
      (bloc) => bloc.state.shoppingCart,
    );
    final productCartMap = compact(productCart);
    return Scaffold(
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
                              .read<BottomNavBarBloc>()
                              .add(RemoveProductFromCartEvent(product.key));
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
}
