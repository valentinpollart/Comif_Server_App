import 'package:Comif_Server_App/models/product.dart';
import 'package:Comif_Server_App/models/user.dart';

class Basket {
  User client;
  Map<Product, int> products;

  Basket({this.client, this.products});

  int getProductTotal(Product product) {
    return products[product] * product.salePrice;
  }

  int getBasketTotal() {
    int total = 0;
    products.forEach((key, value) {
      total += key.salePrice * value;
    });
    return total;
  }
}