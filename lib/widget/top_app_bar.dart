import 'package:flutter/material.dart';

import '../topBar_component/Profile.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  TopAppBar({Key? key})
      : preferredSize = Size.fromHeight(60.0), // Set the preferred height
        super(key: key);

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
            // Navigate to My Orders
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
