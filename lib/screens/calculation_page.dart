import 'package:flutter/material.dart';
import 'bmi_page.dart';
import 'calculator.dart';
import 'financial_management.dart'; // Import halaman financial management

class CalculationPage extends StatelessWidget {
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
                  child: SingleChildScrollView(
                    // Tambahkan SingleChildScrollView untuk scrollable
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
                        SizedBox(height: 80),
                        _buildMenuItem(
                          context,
                          "Kalkulator",
                          Icons.calculate,
                          Colors.pinkAccent,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Calculator()),
                            );
                          },
                        ),
                        SizedBox(height: 30),
                        _buildMenuItem(
                          context,
                          "BMI",
                          Icons.fitness_center,
                          Colors.blueAccent,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BmiPage()),
                            );
                          },
                        ),
                        SizedBox(height: 30),
                        _buildMenuItem(
                          context,
                          "Keuangan", // Menu baru untuk Financial Management
                          Icons.attach_money,
                          Colors.green,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FinancialManagement()),
                            );
                          },
                        ),
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
          width: 200,
          height: 200,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 60,
                  color: color,
                ),
                SizedBox(height: 8.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
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
