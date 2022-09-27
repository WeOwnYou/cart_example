import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_state_management_example/bottom_nav_bar/bloc/bottom_nav_bar_bloc.dart';
import 'package:simple_state_management_example/entity/models/product.dart';

class MenuView extends StatelessWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allProducts = context.select<BottomNavBarBloc, List<Product>>(
        (bloc) => bloc.state.allProducts,);
    if (allProducts.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: allProducts
              .map(
                (product) => Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product.name),
                        ElevatedButton(
                          onPressed: () {
                            context.read<BottomNavBarBloc>().add(
                                AddProductToCartEvent(Product(product.name)),);
                          },
                          child: const Icon(
                            Icons.add_box,
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
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
