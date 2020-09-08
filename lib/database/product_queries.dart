import 'dart:convert';
import 'dart:io';

import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/models/product.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> parseProducts() async {
  final response = await http.get(
      'https://comif.fr/api/products/',
      headers: {HttpHeaders.authorizationHeader: "Bearer " + CachedData.token}
  );
  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to get user list');
  }
}

Future<List<Product>> searchProduct(String search) async {
  final products = await parseProducts();
  products.removeWhere((product) => !product.slug.contains(search));
  products.sort((Product product1, Product product2) => product1.slug.compareTo(product2.slug));
  return products;
}

Future<Product> getProduct(int id) async {
  final response = await http.get(
      "https://comif.fr/api/products/$id",
      headers: {HttpHeaders.authorizationHeader: "Bearer " + CachedData.token}
  );
  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body).cast<String, dynamic>();
    return Product.fromJson(parsed);
  } else {
    throw Exception("Failed to get product (id: $id)");
  }
}