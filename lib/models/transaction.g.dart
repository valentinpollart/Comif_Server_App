// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductInBasket _$ProductInBasketFromJson(Map<String, dynamic> json) {
  return ProductInBasket(
    productId: json['id'] as int,
    quantity: json['quantity'] as int,
    productName: json['name'] as String,
  )..pivot = ProductInBasket.getQuantityFromPivot(
      json['pivot'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ProductInBasketToJson(ProductInBasket instance) =>
    <String, dynamic>{
      'id': instance.productId,
      'quantity': instance.quantity,
      'pivot': instance.pivot,
      'name': instance.productName,
    };

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    userId: json['user_id'] as int,
    products: (json['products'] as List)
        ?.map((e) => e == null
            ? null
            : ProductInBasket.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..total = json['value'] as int
    ..createdAt = json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String);
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'products': instance.products?.map((e) => e?.toJson())?.toList(),
      'value': instance.total,
      'created_at': instance.createdAt?.toIso8601String(),
    };
