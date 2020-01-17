import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providr/models/product.dart';
import 'package:providr/providers/cart_state.dart';
import 'package:providr/providers/products_state.dart';
import 'package:providr/screens/add_product_screen.dart';
import 'package:providr/screens/cart_screen.dart';
import 'package:providr/screens/product_detail_screen.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(

      providers: [
        ChangeNotifierProvider<ProductsState>(
          create: (BuildContext context)=> ProductsState(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context)=> CartState(),
        ),
      ],

      child: MaterialApp(
              title: 'Provider Test',
              home: ProductsScreen(),
            ),

    );
  }
}


class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  
  
  @override
  Widget build(BuildContext context) {
    ProductsState productsState = Provider.of<ProductsState>(context);
    CartState cartState = Provider.of<CartState>(context);

    return Scaffold(

      body: SafeArea(
        child: Container(
          child: ListView(

            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Text(
                    'Found ${productsState.products.length.toString()} products'
                  ),
                  
                  Text(
                    'Cart has ${cartState.items.length.toString()} items'
                  ),

                ],
              ),

              ...productsState.products.map((Product product) {
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.price.toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: ()=> cartState.add(product: product),
                  ),
                  onTap: ()=> this._viewDetails(product.id),
                );
              }).toList(),

              RaisedButton.icon(
                icon: Icon(Icons.shopping_cart),
                label: Text('View Cart'),
                onPressed: ()=> this._goViewCart(),
              )


            ],

          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=> this._goAddProduct(),
      ),
      
    );
  }// build


  
  void _goViewCart() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context)=> CartScreen()
      )
    ) ; 
  }// void _goViewCart() { .. }

  void _goAddProduct() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context)=> AddProductScreen()
      )
    );
  }// void _goAddProduct() { .. }

  void _viewDetails(String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context)=> ProductDetailScreen(id)
      )
    );
  }

}
