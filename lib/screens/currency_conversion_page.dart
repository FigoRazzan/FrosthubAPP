import 'package:flutter/material.dart';

class CurrencyConversionPage extends StatefulWidget {
  @override
  _CurrencyConversionPageState createState() => _CurrencyConversionPageState();
}

class _CurrencyConversionPageState extends State<CurrencyConversionPage> {
  String fromCurrency = "USD";
  String toCurrency = "IDR";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Konversi Mata Uang")),
      body: Column(
        children: [
          DropdownButton<String>(
            value: fromCurrency,
            items: ["USD", "IDR", "EUR"].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value), // Tambahkan child untuk teks
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                fromCurrency = newValue!;
              });
            },
          ),
          DropdownButton<String>(
            value: toCurrency,
            items: ["USD", "IDR", "EUR"].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value), // Tambahkan child untuk teks
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                toCurrency = newValue!;
              });
            },
          ),
          // Tambahkan widget konversi mata uang di sini
        ],
      ),
    );
  }
}
