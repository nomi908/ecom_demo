import 'package:ecommerce_demo/providers/addtocart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddtocartScreen extends StatelessWidget {
  const AddtocartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addtocartProvider = Provider.of<AddToCartProvider>(context,);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add to Cart',),
        centerTitle: true,
      ),
      body: addtocartProvider.cartitems.isEmpty ? Center(child: Text('No items in cart'))
      : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text('Total Amount : ${addtocartProvider.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: addtocartProvider.cartitems.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {

                final product = addtocartProvider.cartitems[index];
                return ListTile(
                  leading: Image.network(product.images![0]),
                  title: Text(product.title!),
                  subtitle: Text(product.price.toString()),
                  trailing: IconButton(onPressed: (){
                    addtocartProvider.removeFromCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Product removed from cart')),
                    );
                  }, icon: Icon(Icons.delete)),

                );

            },),
          ),



        ],
      ),
    );
  }
}
