import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/pages/test_page.dart';
import 'package:flutter_e_commerce/product.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'pages/detail_product.dart';
import 'pages/list_products.dart';
import 'pages/panier_model.dart';
import 'pages/panier_page.dart';

class ECommerceApp extends StatelessWidget {
  ECommerceApp({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const ListProductsPages();
          //return const TestPage();
        },
        routes: [
          GoRoute(
            path: 'detail',
            builder: (BuildContext context, GoRouterState state) {
              return DetailProductPage(product : state.extra as Product);
            },
          ),
          GoRoute(
            path: 'panier',
            builder: (_,__)=>const PanierPage()
          )
        ]
      ),

    ],
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create :(_)=> Panier(),
      child: MaterialApp.router(
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: 'Flutter E-Commerce',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
      ),
    );
  }
}