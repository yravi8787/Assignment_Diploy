import 'dart:convert';

import 'package:assignment_diploy/models/products.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ProductService {
  final String apiUrl = "https://dummyjson.com/products";

  List<Product> products = [];
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      for (var i = 0; i < jsonDecode(response.body)['products'].length; i++) {
        products.add(
          Product.fromJson(
            jsonEncode(
              jsonDecode(response.body)['products'][i],
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
    return products;
  }
}
