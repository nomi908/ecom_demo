import 'dart:convert';

import 'package:ecommerce_demo/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductApiService{

  Future<ProductModel> getAllProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    var data = jsonDecode(response.body.toString());
    print('Response body $data');
    if(response.statusCode == 200){
      print('Product Model $data');
      return ProductModel.fromJson(data);
    }else{
      print('Error occured');
      return ProductModel.fromJson(data);
    }

  }
}