import 'package:flutter/material.dart';
import '../topBar_component/cart.dart'; // Import CartScreen

class PetsScreen extends StatelessWidget {
  final List<String> categories = ['Dogs', 'Cats', 'Birds', 'Fish'];

  @override
  Widget build(BuildContext context) {
    // Initialize an empty cartItems list to hold the items added to the cart
    List<Map<String, dynamic>> cartItems = [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Category'),
        centerTitle: true, // Centers the title
        automaticallyImplyLeading: false,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.shopping_cart),
          //   onPressed: () {
          //     // Navigate to the Cart Screen
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => CartScreen(cartItems: cartItems),
          //       ),
          //     );
          //   },
          // ),
        ],
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
                  builder: (context) => ProductsScreen(
                    category: categories[index],
                    cartItems:
                        cartItems, // Pass the cartItems list to ProductsScreen
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

class ProductsScreen extends StatefulWidget {
  final String category;
  final List<Map<String, dynamic>> cartItems; // Accept the cartItems list

  ProductsScreen({required this.category, required this.cartItems});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final Map<String, List<Map<String, dynamic>>> productsData = {
    'Dogs': [
      {'name': 'Dog Food', 'price': 30, 'image': 'assets/food(m).jpeg'},
      {'name': 'Leash', 'price': 15, 'image': 'assets/leash.jpeg'},
      {
        'name': 'Dog Dental Chews',
        'price': 15,
        'image': 'assets/Dog Dental Chews.jpeg'
      },
      {'name': 'Dog Bed', 'price': 15, 'image': 'assets/bed.jpeg'},
      {'name': 'Dog Brush', 'price': 15, 'image': 'assets/brush.jpg'},
      {'name': 'Dog Chew Toy', 'price': 15, 'image': 'assets/chew toy.jpeg'},
      {
        'name': 'Collar with ID Tag',
        'price': 50,
        'image': 'assets/color_id.jpeg'
      },
      {'name': 'Treat', 'price': 50, 'image': 'assets/treat.jpg'},
      {'name': 'Toys', 'price': 50, 'image': 'assets/toy.png'},
      {'name': 'Dog Shampoo', 'price': 50, 'image': 'assets/shampoo.jpeg'},
      {
        'name': 'Medicine',
        'price': 50,
        'image': 'assets/Puppy Training Pads.jpg'
      },
    ],
    'Cats': [
      {'name': 'Cat Food', 'price': 25, 'image': 'assets/cfood.jpeg'},
      {'name': 'Cat Litter', 'price': 20, 'image': 'assets/litter.jpg'},
      {'name': 'bowl', 'price': 40, 'image': 'assets/water.jpeg'},
      {'name': 'Toys', 'price': 40, 'image': 'assets/ball.jpg'},
      {'name': 'Pet Carrier', 'price': 40, 'image': 'assets/carrier.jpeg'},
      {'name': 'Bed', 'price': 40, 'image': 'assets/cat_bed.jpeg'},
      {'name': 'grooming tools', 'price': 40, 'image': 'assets/grooming.jpg'},
      {
        'name': 'Identification and Microchip',
        'price': 40,
        'image': 'assets/Identification and Microchip.jpeg'
      },
      {'name': 'Scratching Post', 'price': 40, 'image': 'assets/scratch.jpeg'},
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

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      widget.cartItems.add(product); // Add item to cartItems
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${product['name']} added to cart'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Essentials for ${widget.category}'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the Cart Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cartItems: widget.cartItems),
                ),
              );
            },
          ),
        ],
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
                  _addToCart(filteredProducts[index]); // Add item to cart
                },
                child: Text('Add to Cart'),
              ),
            ),
          );
        },
      ),
    );
  }
}
