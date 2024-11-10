import 'package:flutter/material.dart';
import 'temperature_conversion_page.dart';
import 'currency_conversion_page.dart';

class ConversionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal, // Background seperti sebelumnya
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Konversi',
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
                          "Pilih Menu Konversi",
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
                        "Konversi Suhu",
                        Icons.thermostat_rounded,
                        Colors.orangeAccent,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TemperatureConversionPage()),
                          );
                        },
                      ),
                      SizedBox(height: 50),
                      _buildMenuItem(
                        context,
                        "Konversi Mata Uang",
                        Icons.monetization_on_rounded,
                        const Color.fromARGB(
                            255, 34, 240, 141), // Ganti dengan warna hijau
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CurrencyConversionPage()),
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
        // Membuat item berada di tengah
        child: Container(
          width: 200, // Ukuran lebih besar untuk container
          height: 200, // Ukuran lebih besar agar lebih berbentuk persegi
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: color
                .withOpacity(0.2), // Transparansi warna untuk latar belakang
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
                  color: color, // Sesuaikan dengan warna hijau
                ),
                SizedBox(height: 8.0), // Jarak antara icon dan teks
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18, // Ukuran teks lebih besar
                    fontWeight: FontWeight.bold,
                    color: color, // Sesuaikan warna teks dengan warna hijau
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
