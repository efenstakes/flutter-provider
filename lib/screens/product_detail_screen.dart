import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providr/models/product.dart';
import 'package:providr/providers/products_state.dart';




class ProductDetailScreen extends StatelessWidget {
  final String id;

  ProductDetailScreen(this.id);

  @override 
  Widget build(BuildContext context) {
    ProductsState productsState = Provider.of(context);
    Product product = productsState.getProduct(id);

    return Scaffold(
     
      appBar: AppBar(
        title: Text('${product.name} Details'), 
        centerTitle: true,
        // bottomOpacity: 0.5,
        // backgroundColor: Colors.transparent,
      ),

      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[

              Text(
                product.id
              ),

              Text(
                product.name
              ),

              Text(
                'Price ${product.price.toString()}'
              )
                 

            ],
          ),
        ),
      ),

    );
  }

}