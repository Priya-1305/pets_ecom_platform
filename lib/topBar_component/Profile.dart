import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../screens/sign_in_screen.dart';
import '../order/view_order.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display user name
            if (user?.displayName != null)
              Text(
                'Name: ${user?.displayName}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 16),

            // Display user email
            Text(
              'Email: ${user?.email}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewOrdersScreen()),
                );
              },
              child: Text('View Your Orders'),
            ),

            // Logout button
            ElevatedButton(
              onPressed: () async {
                // Sign out from Google
                await GoogleSignIn().signOut();
                // Sign out from Firebase
                await FirebaseAuth.instance.signOut();
                // After logout, navigate back to SignInScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
