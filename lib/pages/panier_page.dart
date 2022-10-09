import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'panier_model.dart';

class PanierPage extends StatefulWidget {
  const PanierPage({Key? key}) : super(key: key);

  @override
  State<PanierPage> createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Panier"),),
      body: Consumer<Panier>(
        builder:(context, panier, child) => Column(
          children: [
            ListProductInCart(panier),
            Total(panier)
          ],
        ),
      ),
    );
  }
}

class Total extends StatelessWidget {
  final Panier panier;

  Total(this.panier,{
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Votre total est de "),
            Text("${panier.getAllPrices()}€",style: TextStyle(fontWeight: FontWeight.bold)),
        ],),
      ),
    );
  }
}

class ListProductInCart extends StatelessWidget {
  final Panier panier;
  ListProductInCart(this.panier,{
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount:panier.listProducts.length,
        itemBuilder: (context,index){
          final product = panier.listProducts[index];
          return ListTile(
            title: Text(product.title),
            trailing: Text("${product.price}€",style: TextStyle(fontWeight: FontWeight.bold),),
          );
        }
      ),
    );
  }
}
