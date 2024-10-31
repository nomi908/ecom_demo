import 'package:ecommerce_demo/models/product_model.dart';
import 'package:ecommerce_demo/providers/addtocart_provider.dart';
import 'package:ecommerce_demo/providers/bottom_navbar_provider.dart';
import 'package:ecommerce_demo/providers/product_provider.dart';
import 'package:ecommerce_demo/screens/addtocart_screen.dart';
import 'package:ecommerce_demo/screens/product_detail_screen.dart';
import 'package:ecommerce_demo/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ProductMainScreen extends StatefulWidget {
  const ProductMainScreen({super.key,});

  @override
  State<ProductMainScreen> createState() => _ProductMainScreenState();
}

class _ProductMainScreenState extends State<ProductMainScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value){
      Provider.of<ProductProvider>(context, listen: false).fetchAllProducts();

    });

  }
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final bottomNavbarProvider = Provider.of<BottomNavbarProvider>(context);
    final addToCartProvider = Provider.of<AddToCartProvider>(context);
    print('product provider $productProvider');
    return Scaffold(
      appBar: AppBar(title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Pro', // This part will be styled separately
              style: TextStyle(
                color: Colors.blue, // Color for 'Pro'
                fontSize: 20, // Font size for 'Pro'
                fontWeight: FontWeight.bold, // Font weight for 'Pro'
              ),
            ),
            TextSpan(
              text: ' Shopping', // This part will use the default text style
              style: TextStyle(
                color: Colors.black, // Color for the rest of the title
                fontSize: 20, // Font size for the rest of the title
              ),
            ),
          ],
        ),
      ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
          }, icon: Icon(Icons.search_rounded)),
          Stack(
            children: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return AddtocartScreen();
                }));
              }, icon: Icon(Icons.shopping_cart)),
              if(addToCartProvider.cartitems.isNotEmpty)
                Positioned(right: 8.0, top: 8.0,
                  child: Container(padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                    alignment: Alignment.center,
                    child: Text(addToCartProvider.cartitems.length.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 12),),),
                )
            ],
          ),

        ]),
      body: bottomNavbarProvider.selectedIndex == 0 ?
      productProvider.isLoading ? Center(child: CircularProgressIndicator(),)
        : productProvider.productModel == null ? Center(child: Text('No Product Found'),)
        : MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
          itemCount: productProvider.productModel!.products!.length,
          itemBuilder: (context, index){
            final product = productProvider.productModel!.products![index];
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ProductDetailScreen(dproduct: product,);
                }));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(product.images![0], fit: BoxFit.cover, height: 100, width: double.infinity,),
                      SizedBox(height: 3), // Add spacing between image and text
                      Text(product.title!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), maxLines: 2,),
                      SizedBox(height: 3), // Add spacing between image and text
                      Text(product.brand != null ? product.brand! : 'No Brand', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),),
                      SizedBox(height: 3), // Add spacing between image and text
                      Text('\$${product.price!}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      SizedBox(height: 3), // Add spacing between image and text
                      Text('save upto ${product.discountPercentage.toString()}\%',),
                      Row(
                        children: [
                          Text('Rating: ${product.rating!}', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return Icon(
                                index <  product.rating! ? Icons.star : Icons.star_border,
                                color:  product.rating!> 3.4 ? Colors.green : Colors.red,
                              size: 12,);
                            }),
                          ),
                        ],
                      ),
                      SizedBox(height: 3,),
                      Text(product.shippingInformation!, style: TextStyle(fontSize: 10),),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: (){
                          addToCartProvider.addToCart(product);
                          ScaffoldMessenger.of(context).
                          showSnackBar(SnackBar(content: Text("Added to cart")));
                        }, child: Text("Add to cart", style: TextStyle(
                          color: Colors.white
                        ),),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.blueAccent),
                          ),
                          backgroundColor: Colors.blueAccent,
                        ),),
                      )
                      

                    ],
                  ),
                ),
              ),
            );
          })
      : AddtocartScreen(),
      bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home' ),
        BottomNavigationBarItem(icon:
        Stack(
          children: [
            Icon(Icons.shopping_cart),
            if(addToCartProvider.cartitems.isNotEmpty)
              Positioned(
                right: 0,
                top: 0,
                child: Container(padding: EdgeInsets.all(2),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                alignment: Alignment.center,
                child: Text(
                  addToCartProvider.cartitems.length.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 12),),),
                )
          ],
        ),label: 'Cart'),

        // Icon(Icons.shopping_cart), label: 'Cart'

      ],
      currentIndex: bottomNavbarProvider.selectedIndex,
      selectedItemColor: Colors.blueAccent,
      onTap: (index) => bottomNavbarProvider.setSelectedIndex(index),),
    );
  }
}
