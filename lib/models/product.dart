class SizeInfo {
  final String size;
  final bool available;
  final int quantity;

  const SizeInfo({
    required this.size,
    required this.available,
    required this.quantity,
  });

  factory SizeInfo.fromJson(Map<String, dynamic> json) {
    return SizeInfo(
      size: json['size'] as String,
      available: json['available'] as bool,
      quantity: json['quantity'] as int,
    );
  }
}

class Product {
  final String barcode;
  final String name;
  final String brand;
  final double price;
  final String imageUrl;
  final String category;
  final List<SizeInfo> sizes;

  const Product({
    required this.barcode,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.sizes,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      barcode: json['barcode'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] as String? ?? '',
      category: json['category'] as String? ?? '',
      sizes: (json['sizes'] as List<dynamic>)
          .map((e) => SizeInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
