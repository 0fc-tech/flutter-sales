import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/pages/panier_model.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../product.dart';

class ListProductsPages extends StatefulWidget {
  const ListProductsPages({Key? key}) : super(key: key);

  @override
  State<ListProductsPages> createState() => _ListProductsPagesState();
}

class _ListProductsPagesState extends State<ListProductsPages> {
  bool isList = true;

  void changeDisplayMode(){
    setState(() {
      isList = !isList;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Commerce"),
        actions: [
          IconButton(onPressed:() =>changeDisplayMode(),
            icon: isList ? const Icon(Icons.grid_view_rounded): const Icon(Icons.view_list) ),
          IconButton(onPressed:() => context.go("/panier"),
              icon: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.shopping_cart),
                  //context.select<Panier,int>((value) => value.listProducts.length)
                  //context.watch<Panier>().listProducts.length
                  Consumer<Panier>(builder: (context, cart, child) {
                    final sizeCart = cart.listProducts.length;
                    return sizeCart <= 0 ?  Container(): BadgeCart(sizeCart);
                  }),
                ],
              )
          ),
        ],
      ),
      body: FutureBuilder<Response>(
        future: get(Uri.parse("https://fakestoreapi.com/products")),
        builder: (context, snapshot) {
          var res = snapshot.data;
          if(res == null) {
            return  _buildShimmer();
          }try{
            List<Product> listProducts = parseProducts(res.body);
            return
              isList ?
                ListViewProducts(
                  listProducts: listProducts,
                  panierProvider: context.read<Panier>(),
                )
              :
              GridViewProducts(listProducts: listProducts);
          }catch(e){
            return Center(child: Column(
              children: const [
                Text("Erreur lors du téléchargement des produits"),
                Icon(Icons.error)
              ],
            ),);
          }
        }
      ),
    );
  }

  Widget _buildShimmer(){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 48.0,
                        height: 48.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: 40.0,
                              height: 8.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                itemCount: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BadgeCart extends StatelessWidget {
  final int numberArticles;
  const BadgeCart(this.numberArticles  ,{
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -5,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color :Colors.red),
        child: Text(
          numberArticles.toString(),
          style: const TextStyle(color:Colors.white),
        )
      ),
    );
  }
}

class ListViewProducts extends StatelessWidget {
  const ListViewProducts({
    Key? key,
    required this.listProducts,
    required this.panierProvider,
  }) : super(key: key);

  final List<Product> listProducts;
  final Panier panierProvider ;


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, context)=> const Divider(),
      itemCount: listProducts.length,
      itemBuilder: (context,index){
        var product = listProducts[index];
        return ListTile(
          onTap: () => GoRouter.of(context).go("/detail",extra: product),
          leading: Hero(
            tag: product.id,
            child: Image.network(product.image,
              width: 90.0,height: 90.0,
              //loadingBuilder: (_,__,___)=> Container(width: 90.0,height: 90.0,color: Colors.white,),
            ),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(product.title,overflow: TextOverflow.clip)),
            ],
          ),
          subtitle:  Text("${product.price}€",style: Theme.of(context).textTheme.titleLarge),
          trailing: TextButton(child: const Text("AJOUTER"), 
            onPressed:()=> panierProvider.addItem(product)
          ,),
        );
      }
    );
  }
}

class GridViewProducts extends StatelessWidget {
  const GridViewProducts({
    Key? key,
    required this.listProducts,
  }) : super(key: key);

  final List<Product> listProducts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: listProducts.length,
      itemBuilder: (context,index){
        var product = listProducts[index];
        return GestureDetector(
          onTap: () => GoRouter.of(context).push("/detail",extra: product),
          child: Card(
            child: Column(
              children: [
                Hero(
                  tag: product.id,
                  child: Image.network(product.image,
                    width: 90.0,height: 90.0,),
                ),
                Text(product.title,overflow: TextOverflow.clip,maxLines: 1,),
                Text("${product.price}€",style: Theme.of(context).textTheme.titleLarge)
              ],
            ),
          ),
        );
      }
    );
  }
}
