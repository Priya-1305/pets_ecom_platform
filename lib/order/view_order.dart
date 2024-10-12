import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewOrdersScreen extends StatefulWidget {
  @override
  _ViewOrdersScreenState createState() => _ViewOrdersScreenState();
}

class _ViewOrdersScreenState extends State<ViewOrdersScreen> {
  late Stream<QuerySnapshot> ordersStream;

  @override
  void initState() {
    super.initState();
    // Get the orders stream for the current user
    ordersStream = FirebaseFirestore.instance.collection('orders').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ordersStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching orders'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No orders found'));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var order = orders[index].data() as Map<String, dynamic>;
              List<dynamic> items =
                  order['items']; // Get items as List<dynamic>

              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('Order #${orders[index].id}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${order['user']['name']}'),
                      Text('Phone: ${order['user']['phone']}'),
                      Text('Address: ${order['address']}'),
                      Text('Status: ${order['status']}'),
                      // Display items
                      ...items.map((item) {
                        // Cast each item to Map<String, dynamic>
                        var itemData = item as Map<String, dynamic>;
                        return Text(
                            '${itemData['name']} (Quantity: ${itemData['quantity']})');
                      }).toList(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
