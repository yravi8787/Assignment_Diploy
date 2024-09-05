import 'package:assignment_diploy/models/cart.dart';
import 'package:assignment_diploy/models/products.dart';
import 'package:assignment_diploy/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    bool isProductInCart() {
      return cart.items.any((item) => item.product.id == product.id);
    }

    int productQuantity() {
      final cartItem = cart.items.firstWhere(
        (item) => item.product.id == product.id,
        orElse: () => CartItem(product: product, quantity: 0),
      );
      return cartItem.quantity;
    }

    void handleAddtocard() {
      cart.addProduct(product, quantity: 1);
    }

    void _handleUpdateQuantity(int quantity) {
      cart.addProduct(product, quantity: quantity - productQuantity());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  product.images[0],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${product.price}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              if (!isProductInCart())
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      handleAddtocard();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Add to Cart Successfully'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // Background color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: const Text(
                      'Add To Cart',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              else
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _handleUpdateQuantity(productQuantity() - 1);
                        },
                        child: const Text("-")),
                    const SizedBox(width: 10),
                    Text("${productQuantity()}"),
                    const SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: () {
                          _handleUpdateQuantity(productQuantity() + 1);
                        },
                        child: const Text("+")),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
