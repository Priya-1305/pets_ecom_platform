import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderForm extends StatefulWidget {
  final List<Map<String, dynamic>> items; // Accept items from the CartScreen

  OrderForm({required this.items}); // Constructor to initialize items

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String phone = '';
  String address = '';

  Future<void> submitOrder() async {
    if (_formKey.currentState!.validate()) {
      // Create order data to send to Firestore
      final orderData = {
        'user': {'name': name, 'phone': phone},
        'items': widget.items, // Use the passed cart items
        'address': address,
        'status': 'pending',
        'timestamp':
            FieldValue.serverTimestamp(), // Automatically set the server time
      };

      // Send order data to Firestore
      await FirebaseFirestore.instance.collection('orders').add(orderData);
      // Show success message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Order placed successfully!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Place Order')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
                onChanged: (value) => name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter your phone number' : null,
                onChanged: (value) => phone = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter delivery address' : null,
                onChanged: (value) => address = value,
              ),
              ElevatedButton(
                onPressed: submitOrder,
                child: Text('Submit Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
