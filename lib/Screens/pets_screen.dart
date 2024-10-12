import 'package:flutter/material.dart';

class PetsScreen extends StatelessWidget {
  final List<String> categories = ['Dogs', 'Cats', 'Birds', 'Fish'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Category'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.pets),
            title: Text(categories[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductsScreen(category: categories[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductsScreen extends StatefulWidget {
  final String category;

  ProductsScreen({required this.category});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  // Example data for pet essentials
  final Map<String, List<Map<String, dynamic>>> productsData = {
    'Dogs': [
      {'name': 'Dog Food', 'price': 30, 'image': 'assets/food(m).jpeg'},
      {'name': 'Leash', 'price': 15, 'image': 'assets/leash.jpeg'},
      {'name': 'Leash', 'price': 15, 'image': 'assets/toy.jpeg'},
      {'name': 'Leash', 'price': 15, 'image': 'assets/leash.jpeg'},
      {'name': 'Leash', 'price': 15, 'image': 'assets/leash.jpeg'},
      {'name': 'Leash', 'price': 15, 'image': 'assets/leash.jpeg'},
      {'name': 'Medicine', 'price': 50, 'image': 'assets/dog_medicine.jpg'},
    ],
    'Cats': [
      {'name': 'Cat Food', 'price': 25, 'image': 'assets/cat_food.jpg'},
      {'name': 'Cat Litter', 'price': 20, 'image': 'assets/cat_litter.jpg'},
      {'name': 'Medicine', 'price': 40, 'image': 'assets/cat_medicine.jpg'},
    ],
    // Add data for other categories like Birds, Fish
  };

  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = productsData[widget.category] ?? [];
  }

  void _filterProducts(String query) {
    final products = productsData[widget.category] ?? [];
    setState(() {
      filteredProducts = products
          .where((product) =>
              product['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Essentials for ${widget.category}'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterProducts,
              decoration: InputDecoration(
                hintText: 'Search essentials...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.asset(filteredProducts[index]['image']),
              title: Text(filteredProducts[index]['name']),
              subtitle: Text('\$${filteredProducts[index]['price']}'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Handle order now action
                },
                child: Text('Buy Now'),
              ),
            ),
          );
        },
      ),
    );
  }
}
