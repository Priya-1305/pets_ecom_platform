import 'package:flutter/material.dart';
import '../order/order_details.dart'; // Import the Order Details screen

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  CartScreen({required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Function to remove an item from the cart
  void _removeItemFromCart(int index) {
    setState(() {
      widget.cartItems.removeAt(index); // Remove item from the cart
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item removed from cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total bill
    double totalBill =
        widget.cartItems.fold(0, (sum, item) => sum + item['price']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          // List of cart items
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(widget.cartItems[index]['image']),
                  title: Text(widget.cartItems[index]['name']),
                  subtitle: Text('\$${widget.cartItems[index]['price']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      _removeItemFromCart(index); // Remove item from cart
                    },
                  ),
                );
              },
            ),
          ),
          // Total and Place Order Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Total: \$${totalBill.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderForm(
                            items: widget.cartItems), // Pass cart items
                      ),
                    );
                  },
                  child: Text('Place Order'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
