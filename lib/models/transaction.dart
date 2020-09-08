import 'package:Comif_Server_App/models/product.dart';
import 'package:Comif_Server_App/models/user.dart';

class ProductInBasket {
  int productId;
  int quantity;

  ProductInBasket({this.productId, this.quantity})
}

class Transaction {
  int userId;
  List<ProductInBasket> products;

  Transaction({this.userId, this.products});

  int getProductQuantity(int productId) {
    final ProductInBasket product = products.firstWhere((element) =>
    element.productId == productId);
    if (ProductInBasket == null){
      return null;
    }
    return product.quantity;
  }
}