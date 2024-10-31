import 'package:ecommerce_demo/models/product_model.dart';
import 'package:ecommerce_demo/services/product_apiservice.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier{
  bool _isLoading = false;
  ProductModel? _productModel;

  bool get isLoading => _isLoading;
  ProductModel? get productModel => _productModel;

  Future<void> fetchAllProducts() async {
    _isLoading = true;
    notifyListeners();

    try{
      _productModel = await ProductApiService().getAllProducts();
      print('fetched Product Model $productModel');
    }catch(e){
      _productModel = null;
      print('Error!! Something Went Wrong $e');
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }


}