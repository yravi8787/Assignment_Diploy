import 'package:flutter/material.dart';
import 'package:assignment_diploy/services/cart_service.dart';
import 'package:provider/provider.dart';
import 'package:assignment_diploy/models/products.dart';
import 'package:assignment_diploy/models/cart.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    int productQuantity(Product product) {
      final cartItem = cart.items.firstWhere(
        (item) => item.product.id == product.id,
        orElse: () => CartItem(product: product, quantity: 0),
      );
      return cartItem.quantity;
    }

    void _handleUpdateQuantity(Product product, int quantity) {
      cart.addProduct(product, quantity: quantity - productQuantity(product));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final cartItem = cart.items[index]; // Get CartItem
                final product =
                    cartItem.product; // Access Product from CartItem
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        product.thumbnail,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '\$${product.price * productQuantity(product)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                _handleUpdateQuantity(
                                    product, productQuantity(product) - 1);
                              },
                              child: const Text("-")),
                          const SizedBox(width: 10),
                          Text("${productQuantity(product)}"),
                          const SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: () {
                                _handleUpdateQuantity(
                                    product, productQuantity(product) + 1);
                              },
                              child: const Text("+")),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Text("Total Price ${cart.totalPrice}",
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => {
              const SnackBar(
                content:
                    Text('Order will be placed. Your query has been processed'),
              ),
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal, // Background color
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: const Text(
              "Place Order",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
