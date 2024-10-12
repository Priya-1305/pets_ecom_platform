import 'package:flutter/material.dart';

import '../topBar_component/Profile.dart';
import '../topBar_component/cart.dart';

import '../Screens/pets_screen.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  TopAppBar({Key? key})
      : preferredSize = Size.fromHeight(60.0), // Set the preferred height
        super(key: key);
  List<Map<String, dynamic>> cartItems = [];
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Pet App'),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            // Handle notifications
          },
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            // Navigate to the Cart Screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(cartItems: cartItems),
              ),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
      ],
    );
  }
}
