import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phonenumber_verification/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Firebase Phone No Verification",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
