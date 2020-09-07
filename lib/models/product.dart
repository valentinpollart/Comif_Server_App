class Product {
  final int id;
  final String name;
  final String slug;
  final int salePrice;
  final int stock;
  final int categoryId;
  
  Product({this.id, this.name, this.slug, this.salePrice, this.stock, this.categoryId});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      salePrice: json['sale_price'] as int,
      stock: json['stock'] as int,
      categoryId: json['category_id'] as int,
    );
  }

  String displayPrice() {
    return (this.salePrice/100).toStringAsFixed(2) + "€";
  }
}