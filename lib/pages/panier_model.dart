import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce/product.dart';

class Panier extends ChangeNotifier{
  List<Product> listProducts = List.empty(growable: true);
  Panier();

  addItem(Product product){
    listProducts.add(product);
    notifyListeners();
  }

  removeAll(){
    listProducts.clear();
    notifyListeners();
  }
  num getAllPrices(){
    num total = 0;
    for (var element in listProducts) {
      total += element.price;
    }
    return total;
  }
}