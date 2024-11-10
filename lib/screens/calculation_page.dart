import 'package:flutter/material.dart';
import 'bmi_page.dart';
import 'calculator.dart';

class CalculationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal, // Kembali ke warna teal
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Perhitungan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Pilih Menu",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                      SizedBox(height: 120),
                      _buildMenuItem(
                        context,
                        "Kalkulator",
                        Icons.calculate,
                        Colors.pinkAccent,
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Calculator()));
                        },
                      ),
                      SizedBox(height: 50), // Mengurangi jarak antar menu
                      _buildMenuItem(
                        context,
                        "BMI",
                        Icons.fitness_center,
                        Colors.blueAccent,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BmiPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        // Menambahkan Center untuk memastikan item berada di tengah
        child: Container(
          width: 200, // Ukuran lebih besar untuk container
          height: 200, // Ukuran lebih besar agar lebih berbentuk persegi
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.0), // Membulatkan sudut
          ),
          child: Center(
            // Menempatkan konten di tengah
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Memusatkan konten
              children: [
                Icon(
                  icon,
                  size: 60, // Ukuran ikon lebih besar
                  color: color,
                ),
                SizedBox(height: 8.0), // Jarak antara icon dan teks
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18, // Ukuran teks lebih besar
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
