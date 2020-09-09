import 'package:Comif_Server_App/models/product.dart';
import 'package:Comif_Server_App/models/user.dart';

class ProductInBasket {
  int productId;
  int quantity;

  ProductInBasket({this.productId, this.quantity});
}

class Transaction {
  int userId;
  Map<int, ProductInBasket> products;

  Transaction({this.userId, this.products});

  int getProductQuantity(int productId) {
    return products[productId] == null ? null : products[productId].quantity;
  }


}