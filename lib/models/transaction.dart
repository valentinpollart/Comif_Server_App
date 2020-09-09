import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable(explicitToJson: true)

class ProductInBasket {
  @JsonKey(name: "id")
  int productId;

  int quantity;

  ProductInBasket({this.productId, this.quantity});

  factory ProductInBasket.fromJson(Map<String, dynamic> json) => _$ProductInBasketFromJson(json);

  Map<String, dynamic> toJson() => _$ProductInBasketToJson(this);
}

@JsonSerializable(explicitToJson: true)

class Transaction {

  @JsonKey(name: "user_id")
  int userId;
  List<ProductInBasket> products;
  @JsonKey(ignore: true)
  int total = 0;

  Transaction({this.userId, this.products});

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  int getProductQuantity(int productId) {
    final targetedProduct = products.firstWhere((element) => element.productId == productId, orElse: () => null);
    return targetedProduct == null ? null : targetedProduct.quantity;
  }

  void empty() {
    userId = null;
    products = new List<ProductInBasket>();
  }

  void setProduct(int productId, ProductInBasket productInBasket) {
     final index = products.indexWhere((element) => element.productId == productId);
     if ( index == -1) {
       products.add(productInBasket);
     } else {
       products[index] = productInBasket;
     }
  }

  ProductInBasket getProduct(int productId) {
    return products.firstWhere((element) => element.productId == productId);
  }

}
