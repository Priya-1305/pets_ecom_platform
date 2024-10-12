import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: 'AIzaSyDutQupBXg2BGnBzdfeVcF9uCvirQFB9aE',
      appId: '1:375926798538:web:7195f6bca98c2eecd39c33',
      messagingSenderId: '375926798538',
      projectId: 'e-commerce-agent-86a0e',
      authDomain: "e-commerce-agent-86a0e.firebaseapp.com",
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pet App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: SplashScreen());
  }
}
