import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable(explicitToJson: true)

class ProductInBasket {
  @JsonKey(name: "id")
  int productId;

  @JsonKey()
  int quantity;

  @JsonKey(name: "pivot", fromJson: getQuantityFromPivot)
  int pivot;

  @JsonKey(name: "name")
  String productName;

  @JsonKey(ignore: true)
  int price;

  ProductInBasket({this.productId, this.quantity, this.productName, this.price});

  factory ProductInBasket.fromJson(Map<String, dynamic> json) => _$ProductInBasketFromJson(json);

  Map<String, dynamic> toJson() => _$ProductInBasketToJson(this);

  static int getQuantityFromPivot(Map<String, dynamic> json) {
    return json['quantity'] as int;
  }
}

@JsonSerializable(explicitToJson: true)

class Transaction {

  @JsonKey(name: "user_id")
  int userId;

  List<ProductInBasket> products;

  @JsonKey(name: "value")
  int total = 0;

  @JsonKey(name: "created_at")
  DateTime createdAt;

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

  void setProduct(int productId, ProductInBasket productInBasket, int productPrice) {
     final index = products.indexWhere((element) => element.productId == productId);
     if ( index == -1) {
       products.add(productInBasket);
       total += productPrice;
     } else if (productInBasket.quantity == 0) {
       products.removeWhere((element) => element.productId == productInBasket.productId);
       total -= productPrice;
     } else {
       if(products[index].quantity < productInBasket.quantity) {
         total += productPrice;
       } else {
         total -= productPrice;
       }
       products[index] = productInBasket;
     }
  }

  ProductInBasket getProduct(int productId) {
    return products.firstWhere((element) => element.productId == productId);
  }

}
