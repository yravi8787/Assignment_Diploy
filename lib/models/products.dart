import 'dart:convert';

// Product Model
class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> images;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.images,
    required this.thumbnail,
  });

  // Convert Product to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'images': images,
      'thumbnail': thumbnail,
    };
  }

  // Create Product from Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      discountPercentage: map['discountPercentage']?.toDouble() ?? 0.0,
      rating: map['rating']?.toDouble() ?? 0.0,
      stock: map['stock'] ?? 0,
      images: List<String>.from(map['images'] ?? []),
      thumbnail: map['thumbnail'] ?? '',
    );
  }

  // Convert Product to JSON
  String toJson() => json.encode(toMap());

  // Create Product from JSON
  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}