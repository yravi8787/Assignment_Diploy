// cart.dart
import 'package:assignment_diploy/models/cart.dart';
import 'package:assignment_diploy/models/products.dart';
import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void addProduct(Product product, {int quantity = 1}) {
    final existingItem = _items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity == 0 && quantity > 0) {
      _items.add(CartItem(product: product, quantity: quantity));
    } else if (existingItem.quantity > 0 || quantity > 0) {
      existingItem.quantity += quantity;
    }

    _removeZeroQuantityItems(); // Remove items with zero quantity
    notifyListeners();
  }

  void updateQuantity(Product product, int newQuantity) {
    final existingItem = _items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (newQuantity > 0) {
      existingItem.quantity = newQuantity;
    } else {
      _items.removeWhere((item) => item.product.id == product.id);
    }

    _removeZeroQuantityItems(); // Remove items with zero quantity
    notifyListeners();
  }

  void removeProduct(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void _removeZeroQuantityItems() {
    _items.removeWhere((item) => item.quantity <= 0);
  }

  double get totalPrice {
    return _items.fold(
        0.0, (sum, item) => sum + (item.product.price * item.quantity));
  }
}
