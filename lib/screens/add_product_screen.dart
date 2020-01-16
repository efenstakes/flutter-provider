import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providr/models/product.dart';
import 'package:providr/providers/products_state.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Product _product = new Product();

  @override
  Widget build(BuildContext context) {
    ProductsState productsState = Provider.of(context);

    return Scaffold(
      
      appBar: AppBar(
        title: Text('Add Product'),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[

             Form(
               key: _formKey,
               child: Column(
                 children: <Widget>[
                  

                  // id
                  TextFormField(
                    keyboardType: TextInputType.text,
                    validator: (String val) {
                      if( val.length > 2 ) return null;
                      return 'Enter an id logner than 4';
                    },
                    onSaved: (String val) {
                      _product.id = val;
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.mail_outline),
                      labelText: 'Enter id',
                    ),
                  ),

                  // name
                  TextFormField(
                    keyboardType: TextInputType.text,
                    validator: (String val) {
                      if( val.length > 4 ) return null;
                      return 'Enter a name logner than 4';
                    },
                    onSaved: (String val) {
                      _product.name = val;
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.mail_outline),
                      labelText: 'Enter name',
                    ),
                  ),
                  
                  // price
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (String val) {
                      if( val.length > 4 ) return null;
                      return 'Enter a price logner than 4';
                    },
                    onSaved: (String val) {
                      _product.price = double.parse(val);
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.mail_outline),
                      labelText: 'Enter price',
                    ),
                  ),

                  // submit btn
                  RaisedButton(
                    child: Text('Add Product'),
                    onPressed: () {

                      if( _formKey.currentState.validate() ) {
                        _formKey.currentState.save();
                        print('all good,');
                        this._addProduct(productsState: productsState);
                        return;
                      }
                      print('error in ');

                    },
                  ),


                 ],
               ),
             ),

            ],
          ),
        ),
      ),

    );
  }// build


  void _addProduct({ ProductsState productsState }) {
    print('id ${_product.id}');
    print('name ${_product.name}');
    print('price ${_product.price.toString()}');
    productsState.addProduct(this._product);
  }// void _addProduct() { .. }

}