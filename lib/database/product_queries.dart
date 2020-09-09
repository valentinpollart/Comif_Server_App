import 'dart:convert';
import 'dart:io';

import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/models/product.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> parseProducts() async {
  var parsed;
  if (await CachedData.isCached('products.json')) {
    parsed = CachedData.fetch('products.json');
  } else {
    final response = await http.get('https://comif.fr/api/products/', headers: {
      HttpHeaders.authorizationHeader: "Bearer " + SharedPrefs.token
    });
    if (response.statusCode == 200) {
      parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to get user list');
    }
  }
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

Future<List<Product>> searchProduct(String search) async {
  final products = await parseProducts();
  products.removeWhere((product) => !product.slug.contains(search));
  products.sort((Product product1, Product product2) =>
      product1.slug.compareTo(product2.slug));
  return products;
}

Future<Product> getProduct(int id) async {
  var parsed;
  if (await CachedData.isCached('products.json')) {
    parsed = CachedData.fetch('products.json');
  } else {
    final response = await http.get('https://comif.fr/api/products/', headers: {
      HttpHeaders.authorizationHeader: "Bearer " + SharedPrefs.token
    });
    if (response.statusCode == 200) {
      parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to get user list');
    }
  }
  final List<Product> productList = parsed.map<Product>((json) => Product.fromJson(json)).toList();
  return productList.firstWhere((element) => element.id == id);
}
