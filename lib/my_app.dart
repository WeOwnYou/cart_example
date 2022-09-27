import 'package:flutter/material.dart';
import 'package:simple_state_management_example/navigation/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ProductsCart',
      routerDelegate: AppRouter.instance().delegate(),
      routeInformationParser: AppRouter.instance().defaultRouteParser(),
    );
  }
}
