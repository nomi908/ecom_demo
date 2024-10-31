import 'package:ecommerce_demo/providers/addtocart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<AddToCartProvider>(context);
    return PopScope(
        onPopInvokedWithResult: (didPop, result) {
      if (didPop) {
        // Reset the filtered products when the back button is pressed
        searchProvider.resetSearch();
      }},
      child:
       Scaffold(
        appBar: AppBar(title: Text('Search'),),
        body: Column(
          children: [
             Padding(padding: EdgeInsets.all(16),
             child: TextField(
               controller: searchController,
               decoration: InputDecoration(
                 hintText: 'Search',
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                 ),
                 suffixIcon: Icon(Icons.search),
      
               ),
               style: TextStyle(color: Colors.black),
               onChanged: (value){
                 print("Search query: $value"); // Add this print to see if the callback is triggered
                 searchProvider.searchProducts(value, context);
               },
             ),),
            Expanded(
              child: Consumer<AddToCartProvider>(
                builder: (context, provider, child) {
                  // Use the filtered products for the list
                  final filteredProducts = provider.filteredProducts;
                  if (filteredProducts.isEmpty) {
                    return Center(child: Text('No products found.')); // Message when no products match
                  }
      
                  return ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ListTile(
                        leading: Image.network(product.images![0]), // Assuming images is a list
                        title: Text(product.title!),
                        subtitle: Text('\$${product.price}'), // Display the price
                        onTap: () {
                          // Handle product tap (e.g., navigate to product details)
                        },
                      );
                    },
                  );
                },
              ),
            ),
            ]
        ),
      ),
    );
  }
}
