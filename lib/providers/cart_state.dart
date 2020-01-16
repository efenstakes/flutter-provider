import 'package:flutter/foundation.dart';
import 'package:providr/models/cart.dart';
import 'package:providr/models/product.dart';


class CartState with ChangeNotifier {
  List<CartItem> items = [];
  double totalCost = 0.0;

  
  // add item
  void add({Product product}) {
    bool exists = this.items.any((CartItem cartItem) {
      return cartItem.product.id == product.id; 
    });
    if( exists ) {
      this.addQuantity(product: product);
      return;
    }
  
    this.justAdd(product: product);
  }// void add({Product product}) { .. }

  void justAdd({Product product}) {
    this.items..add(
                  CartItem(product: product, quantity: 1)
                );
    notifyListeners();
    this._calculateCartTotal();
  }// void justAdd({Product product}) { .. }

  // add quantity for item
  void addQuantity({Product product, int byQuantity=1}) {
    
    // items that dont need changing
    List<CartItem> soundItems = this.items.where((CartItem item) {
      return item.product.id != product.id;
    }).toList();

    // item to change
    CartItem itemToChange = this.items.where((CartItem item) {
      return item.product.id == product.id;
    }).toList()[0];

    itemToChange.quantity = itemToChange.quantity+byQuantity;

    this.items = soundItems..add(itemToChange);
    notifyListeners();
    this._calculateCartTotal();
  }// void addQuantity(Product product, int byQuantity) { .. }


  // reduce quantity for item
  void reduceQuantity({Product product, int byQuantity=1}) {
    
    // items that dont need changing
    List<CartItem> soundItems = this.items.where((CartItem item) {
      return item.product.id != product.id;
    }).toList();

    // item to change
    CartItem itemToChange = this.items.where((CartItem item) {
      return item.product.id == product.id;
    }).toList()[0];

    if( itemToChange.quantity == 1 ) {
      this.items = soundItems;
      notifyListeners();
      return;
    }

    itemToChange.quantity = itemToChange.quantity-byQuantity;

    this.items = soundItems..add(itemToChange);
    notifyListeners();
    this._calculateCartTotal();
  }// void reduceQuantity(Product product, int byQuantity) { .. }


  // remove item
  void remove({Product product}) {
    this.items = this.items.where((CartItem item) {
      return item.product.id != product.id;
    }).toList();
    notifyListeners();
    this._calculateCartTotal();
  }// void remove(Product product) { .. }


  // clear cart
  void clear() {
    this.items = [];
    notifyListeners();
    this._calculateCartTotal();
  }// void clear() { .. }


  // calculate cart total cost
  void _calculateCartTotal() {
    print(' Cart _calculateCartTotal');
    double price = this.items.fold(
                      0.0,
                      (double currentCost, CartItem cartItem) {
                        return currentCost + (cartItem.product.price*cartItem.quantity);
                      }
                  );
    print('Cart _calculateCartTotal >> $price');
    this.totalCost = price;
    notifyListeners();
  }// void calculateCartTotal() { .. }
  


}