import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TemperatureConversionPage extends StatefulWidget {
  @override
  _TemperatureConversionPageState createState() =>
      _TemperatureConversionPageState();
}

class _TemperatureConversionPageState extends State<TemperatureConversionPage> {
  String fromTemperature = "Celsius";
  String toTemperature = "Fahrenheit";
  String inputTemperature = "";
  String convertedTemperature = "";

  // Fungsi untuk mengonversi suhu
  void convertTemperature() {
    double temp = double.tryParse(inputTemperature) ?? 0;
    double result;

    if (fromTemperature == "Celsius") {
      if (toTemperature == "Fahrenheit") {
        result = temp * 9 / 5 + 32;
      } else if (toTemperature == "Kelvin") {
        result = temp + 273.15;
      } else {
        result = temp;
      }
    } else if (fromTemperature == "Fahrenheit") {
      if (toTemperature == "Celsius") {
        result = (temp - 32) * 5 / 9;
      } else if (toTemperature == "Kelvin") {
        result = (temp - 32) * 5 / 9 + 273.15;
      } else {
        result = temp;
      }
    } else {
      // Kelvin
      if (toTemperature == "Celsius") {
        result = temp - 273.15;
      } else if (toTemperature == "Fahrenheit") {
        result = (temp - 273.15) * 9 / 5 + 32;
      } else {
        result = temp;
      }
    }

    setState(() {
      convertedTemperature = formatTemperature(result);
    });
  }

  // Fungsi untuk format angka hasil konversi
  String formatTemperature(double temperature) {
    final formatter = NumberFormat("#,##0.##", "en_US");
    return formatter.format(temperature);
  }

  // Fungsi untuk menambah angka ke input suhu
  void appendNumber(String number) {
    setState(() {
      if (number == "." && inputTemperature.contains("."))
        return; // Cegah titik ganda
      inputTemperature += number;
      convertTemperature();
    });
  }

  // Fungsi untuk membersihkan input
  void clear() {
    setState(() {
      inputTemperature = "";
      convertedTemperature = "";
    });
  }

  // Fungsi untuk menghapus karakter terakhir
  void backspace() {
    setState(() {
      if (inputTemperature.isNotEmpty) {
        inputTemperature =
            inputTemperature.substring(0, inputTemperature.length - 1);
        convertTemperature();
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
          'Konversi Suhu',
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
                  // Input Suhu Awal
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
                              value: fromTemperature,
                              onChanged: (value) {
                                setState(() {
                                  fromTemperature = value!;
                                  convertTemperature();
                                });
                              },
                              items: ["Celsius", "Fahrenheit", "Kelvin"]
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          inputTemperature.isEmpty ? "0" : inputTemperature,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Hasil Konversi Suhu
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
                              value: toTemperature,
                              onChanged: (value) {
                                setState(() {
                                  toTemperature = value!;
                                  convertTemperature();
                                });
                              },
                              items: ["Celsius", "Fahrenheit", "Kelvin"]
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          convertedTemperature.isEmpty
                              ? "0"
                              : convertedTemperature,
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
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(Icons.backspace_outlined),
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
                      color: Colors.red,
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
