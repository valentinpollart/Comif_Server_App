// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductInBasket _$ProductInBasketFromJson(Map<String, dynamic> json) {
  return ProductInBasket(
    productId: json['id'] as int,
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$ProductInBasketToJson(ProductInBasket instance) =>
    <String, dynamic>{
      'id': instance.productId,
      'quantity': instance.quantity,
    };

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    userId: json['user_id'] as int,
    products: (json['products'] as List)
        ?.map((e) => e == null
            ? null
            : ProductInBasket.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'products': instance.products?.map((e) => e?.toJson())?.toList(),
    };
