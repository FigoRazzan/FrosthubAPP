import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyConversionPage extends StatefulWidget {
  @override
  _CurrencyConversionPageState createState() => _CurrencyConversionPageState();
}

class _CurrencyConversionPageState extends State<CurrencyConversionPage> {
  String fromCurrency = "IDR";
  String toCurrency = "SGD";
  String amount = "";
  String convertedAmount = "";

  // Nilai tukar mata uang (disederhanakan)
  Map<String, double> rates = {
    "SGD": 10957.46,
    "IDR": 1, // IDR sebagai basis
    "USD": 15000,
    "EUR": 17000,
  };

  // Simbol mata uang
  Map<String, String> currencySymbols = {
    "SGD": "\$",
    "IDR": "Rp",
    "USD": "\$",
    "EUR": "€",
  };

  // Fungsi untuk menghitung hasil konversi
  void calculate() {
    // Parsing angka dari input dan menangani kesalahan format
    double inputAmount = double.tryParse(amount.replaceAll(",", "")) ?? 0;
    double? fromRate = rates[fromCurrency];
    double? toRate = rates[toCurrency];

    // Pastikan nilai tukar tidak null sebelum melakukan perhitungan
    if (fromRate != null && toRate != null && inputAmount > 0) {
      double result;
      // Kalkulasi dengan memperhitungkan apakah konversi berasal dari IDR atau ke IDR
      if (fromCurrency == "IDR") {
        result = inputAmount / toRate;
      } else if (toCurrency == "IDR") {
        result = inputAmount * fromRate;
      } else {
        result = (inputAmount / fromRate) * toRate;
      }

      setState(() {
        convertedAmount = formatNumber(result);
      });
    } else {
      setState(() {
        convertedAmount = "";
      });
    }
  }

  // Fungsi untuk format angka dengan koma
  String formatNumber(double number) {
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(number);
  }

  // Fungsi untuk menampilkan angka dengan format ribuan di kolom input
  String formatAmount(String amount) {
    if (amount.isEmpty) return "";
    double value = double.tryParse(amount.replaceAll(",", "")) ?? 0;
    return NumberFormat("#,###", "en_US").format(value);
  }

  // Menambah angka ke input dengan format ribuan
  void appendNumber(String number) {
    setState(() {
      if (number == "." && amount.contains(".")) return; // Cegah koma ganda

      amount += number;
      amount = formatAmount(amount); // Format input dengan ribuan
      calculate();
    });
  }

  // Fungsi untuk membersihkan input
  void clear() {
    setState(() {
      amount = "";
      convertedAmount = "";
    });
  }

  // Fungsi untuk menghapus karakter terakhir
  void backspace() {
    setState(() {
      if (amount.isNotEmpty) {
        amount = amount.substring(0, amount.length - 1);
        amount = formatAmount(amount); // Format kembali setelah hapus karakter
        calculate();
      }
    });
  }

  // Tombol angka
  Widget buildNumberButton(String number) {
    return Expanded(
      child: GestureDetector(
        onTap: () => appendNumber(number),
        child: Container(
          height: 60,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Konversi Mata Uang',
          style: TextStyle(color: Colors.black87),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Bagian Input Mata Uang Awal
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            DropdownButton<String>(
                              value: fromCurrency,
                              onChanged: (value) {
                                setState(() {
                                  fromCurrency = value!;
                                  calculate();
                                });
                              },
                              items: currencySymbols.keys.map((currency) {
                                return DropdownMenuItem<String>(
                                  value: currency,
                                  child: Row(
                                    children: [
                                      Text(currencySymbols[currency]!),
                                      SizedBox(width: 4),
                                      Text(
                                        currency,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          amount.isEmpty ? "0" : amount,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Bagian Input Mata Uang Tujuan
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            DropdownButton<String>(
                              value: toCurrency,
                              onChanged: (value) {
                                setState(() {
                                  toCurrency = value!;
                                  calculate();
                                });
                              },
                              items: currencySymbols.keys.map((currency) {
                                return DropdownMenuItem<String>(
                                  value: currency,
                                  child: Row(
                                    children: [
                                      Text(currencySymbols[currency]!),
                                      SizedBox(width: 4),
                                      Text(
                                        currency,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          convertedAmount.isEmpty ? "0" : convertedAmount,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Keypad
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    buildNumberButton("1"),
                    buildNumberButton("2"),
                    buildNumberButton("3"),
                  ],
                ),
                Row(
                  children: [
                    buildNumberButton("4"),
                    buildNumberButton("5"),
                    buildNumberButton("6"),
                  ],
                ),
                Row(
                  children: [
                    buildNumberButton("7"),
                    buildNumberButton("8"),
                    buildNumberButton("9"),
                  ],
                ),
                Row(
                  children: [
                    buildNumberButton("."),
                    buildNumberButton("0"),
                    Expanded(
                      child: GestureDetector(
                        onTap: backspace,
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Icon(Icons.backspace, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: clear,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Clear",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
