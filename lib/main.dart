import 'package:flutter/material.dart';
import 'screens/splashscreen.dart'; // Arahkan ke SplashScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(), // Menampilkan SplashScreen terlebih dahulu
    );
  }
}
