import 'package:flutter/material.dart';
import 'temperature_conversion_page.dart';
import 'currency_conversion_page.dart';
import 'unit_length_page.dart';

class ConversionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
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
                child: SingleChildScrollView(
                  // Added ScrollView
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
                        SizedBox(height: 40), // Reduced spacing
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
                        SizedBox(height: 30), // Reduced spacing
                        _buildMenuItem(
                          context,
                          "Konversi Mata Uang",
                          Icons.monetization_on_rounded,
                          const Color.fromARGB(255, 34, 240, 141),
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CurrencyConversionPage()),
                            );
                          },
                        ),
                        SizedBox(height: 30), // Reduced spacing
                        _buildMenuItem(
                          context,
                          "Konversi Panjang",
                          Icons
                              .straighten, // Changed icon to be more appropriate
                          Colors.blueAccent,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UnitLengthPage()),
                            );
                          },
                        ),
                        SizedBox(
                            height:
                                30), // Added extra spacing at bottom for better scrolling
                      ],
                    ),
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
        child: Container(
          width: 180, // Slightly reduced size
          height: 180, // Slightly reduced size
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius:
                BorderRadius.circular(16.0), // Slightly more rounded corners
            boxShadow: [
              // Added subtle shadow
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 50, // Slightly reduced icon size
                  color: color,
                ),
                SizedBox(height: 12.0),
                Text(
                  title,
                  textAlign: TextAlign.center, // Center text if it wraps
                  style: TextStyle(
                    fontSize: 16, // Slightly reduced text size
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
