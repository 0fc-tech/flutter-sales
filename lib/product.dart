import 'dart:convert';
import 'dart:core';

List<Product> parseProducts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

class Product{
  int id;
  String title;
  num price;
  String description;
  String category ;
  String image;

  Product(this.id,this.title,this.price,this.description,this.category ,this.image);

  Product.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'],
      price = json['price'],
      description = json['description'],
      category = json['category'],
      image = json['image'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'description': description,
    'category': category,
    'image': image,
  };

  @override
  String toString() {
    return 'Product{id: $id, title: $title, price: $price, description: $description, category: $category, image: $image}';
  }
}