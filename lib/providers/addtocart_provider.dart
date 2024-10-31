import 'package:ecommerce_demo/models/product_model.dart';
import 'package:ecommerce_demo/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToCartProvider extends ChangeNotifier{

  List<Products> _cartitems = [];
  double _totalPrice = 0.0;
  List<Products> _filteredProducts = [];


  List<Products> get cartitems => _cartitems;
  double get totalPrice => _totalPrice;
  List<Products> get filteredProducts => _filteredProducts.isNotEmpty
      ? _filteredProducts : _cartitems;

  void addToCart(Products product){
    _cartitems.add(product);
    alltotalPrice();
    notifyListeners();
  }

  void removeFromCart(Products product){
    _cartitems.remove(product);
    alltotalPrice();
    notifyListeners();
  }

  bool isInCart(Products product){
    alltotalPrice();
    return _cartitems.contains(product);
  }

  void alltotalPrice(){
   _totalPrice = _cartitems.fold(0, (previousValue, element) => previousValue + element.price!);
    notifyListeners();
  }

  // Search function to filter products
  void searchProducts(String query, BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    List<Products> allProducts = productProvider.productModel!.products!; // Get all products from ProductProvider

    if (query.isEmpty) {
      _filteredProducts = [];
    } else {
      _filteredProducts = allProducts
          .where((product) => product.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void resetSearch() {
    _filteredProducts.clear();
    notifyListeners();
  }


  }