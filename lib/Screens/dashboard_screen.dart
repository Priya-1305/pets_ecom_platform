import 'package:flutter/material.dart';
import '../widget/top_app_bar.dart';
import '../widget/bottom_navigation_bar.dart';
import 'pets_screen.dart';
import 'chat_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  // List of widgets for each tab
  static List<Widget> _widgetOptions = <Widget>[
    DashboardHome(),
    PetsScreen(),
    ChatScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class DashboardHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      // Middle interactive text and background image
      child: Stack(
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
          Center(
            child: Text(
              'Find Your Perfect Pet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
