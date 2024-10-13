import 'package:flutter/material.dart';
import 'sign_in_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a Stack to overlay text and button over the background image
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/pets.jpg', // Replace with your background image
              fit: BoxFit.cover, // Ensures the image covers the entire screen
              alignment: Alignment.center,
            ),
          ),
          // Overlay to darken the image
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.6), // Semi-transparent overlay
            ),
          ),
          // Main Content
          Positioned(
            left: 20,
            bottom: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Pet App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    // backgroundColor: Colors.amber,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to sign-in screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  child: Text('Start Here!'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
