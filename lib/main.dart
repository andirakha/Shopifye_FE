import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopifye_e_commerce/routing.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopifye',
      home: AuthRouting(),
    );
  }
}
