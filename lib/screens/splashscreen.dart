import 'package:flutter/material.dart';
import 'dart:async';
import 'home_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Timer untuk beralih ke halaman HomePage setelah 10 detik
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Frost Hub",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),

            // Widget untuk animasi loading di luar foto profil
            Stack(
              alignment: Alignment.center,
              children: [
                // Foto Profil
                CircleAvatar(
                  radius: 120,
                  backgroundImage: AssetImage('assets/foto_profil.jpg'),
                ),

                // Animasi Loading di luar foto profil
                LoadingAnimationWidget.discreteCircle(
                  color: Colors.white,
                  size: 260, // Ukuran lingkaran animasi
                ),
              ],
            ),

            SizedBox(height: 20),
            Text(
              "Muhammad Figo Razzan Fadillah",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              "NIM: 152022064",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
