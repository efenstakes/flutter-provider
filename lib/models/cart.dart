

import 'package:providr/models/product.dart';


class CartItem {
  Product product;
  int quantity = 1;
  
  // constructor
  CartItem({ this.product, this.quantity });

}


class Cart {
  List<Product> products;

  void add(Product product) {
    this.products.add(product);
  }

}