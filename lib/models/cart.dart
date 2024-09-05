import 'dart:convert';
import 'package:assignment_diploy/models/products.dart';

// CartItem Model
class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1, // Default quantity to 1
  });

  // Convert CartItem to Map
  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  // Create CartItem from Map
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] ?? 1,
    );
  }

  // Convert CartItem to JSON
  String toJson() => json.encode(toMap());

  // Create CartItem from JSON
  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
