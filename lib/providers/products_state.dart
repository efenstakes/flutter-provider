import 'package:flutter/foundation.dart';
import 'package:providr/models/product.dart';


List<Product> prods = [
  Product( id:'78282', name: 'prod 1', price: 9400.00 ),
  Product( id:'78222', name: 'prod 3', price: 940.00 ),
  Product( id:'78212', name: 'prod 2', price: 200.00 ),
];

class ProductsState with ChangeNotifier {
  List<Product> _products = prods;
  bool _isLoading = false;

  // getters
  List<Product> get products => this._products;
  bool get isLoading => this._isLoading;
  
  // setters
  

  void addProduct(Product product) {
    this.products.add(product);
    notifyListeners();
  }// void addProduct(Product product) { .. }



}