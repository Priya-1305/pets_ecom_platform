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
              // Navigate to breeds screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BreedsScreen(category: categories[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BreedsScreen extends StatelessWidget {
  final String category;
  BreedsScreen({required this.category});

  // Example data
  final Map<String, List<Map<String, dynamic>>> breedsData = {
    'Dogs': [
      {'name': 'Golden Retriever', 'price': 500, 'image': 'assets/dog1.jpg'},
      {'name': 'Labrador', 'price': 450, 'image': 'assets/dog2.jpg'},
    ],
    // Add data for other categories
  };

  @override
  Widget build(BuildContext context) {
    final breeds = breedsData[category] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Breeds of $category'),
      ),
      body: ListView.builder(
        itemCount: breeds.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.asset(breeds[index]['image']),
              title: Text(breeds[index]['name']),
              subtitle: Text('\$${breeds[index]['price']}'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Handle order now action
                },
                child: Text('Order Now'),
              ),
            ),
          );
        },
      ),
    );
  }
}
