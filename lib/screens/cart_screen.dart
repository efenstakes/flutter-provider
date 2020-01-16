import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providr/models/cart.dart';
import 'package:providr/models/product.dart';
import 'package:providr/providers/cart_state.dart';


class CartScreen extends StatelessWidget {
  
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartState cartState = Provider.of(context);

    return Scaffold(
      
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
               
              cartState.items.length > 0
               ?

               Container(
                 child: Column(
                   children: <Widget>[
                      Text(
                        'Cart has ${cartState.items.length.toString()} items'
                      ),

                      ...cartState.items.map((CartItem cartItem) {
                        Product prod = cartItem.product;

                        return ListTile(
                          title: Text(
                            '${cartItem.quantity.toString()} x ${prod.name}'
                          ),
                          subtitle: Text(prod.price.toString()),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: ()=> cartState.remove(product: prod),
                          ),
                        );

                      }).toList(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Text('Total'),

                          Text(
                            cartState.totalCost.toString()
                          ),

                        ],
                      )

                   ],
                 ),
               )  
             
              :
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    
                    Text('You have no products in the cart'),

                    FlatButton.icon(
                      icon: Icon(Icons.shopping_cart),
                      label: Text('Lets Add Some'),
                      onPressed: ()=> this._goBack(context),
                    )

                  ],
                ),
              ),


            ],
          ),
        ),
      ),

    );
  }// Widget build(BuildContext context) { .. }

  void _goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

}