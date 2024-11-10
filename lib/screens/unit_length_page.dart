import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UnitLengthPage extends StatefulWidget {
  @override
  _UnitLengthPageState createState() => _UnitLengthPageState();
}

class _UnitLengthPageState extends State<UnitLengthPage> {
  String fromLength = "Meter";
  String toLength = "Kilometer";
  String inputLength = "";
  String convertedLength = "";

  // Fungsi untuk mengonversi panjang
  void convertLength() {
    double length = double.tryParse(inputLength) ?? 0;
    double result;

    if (fromLength == "Meter") {
      if (toLength == "Kilometer") {
        result = length / 1000;
      } else if (toLength == "Mile") {
        result = length / 1609.34;
      } else if (toLength == "Yard") {
        result = length * 1.09361;
      } else {
        result = length;
      }
    } else if (fromLength == "Kilometer") {
      if (toLength == "Meter") {
        result = length * 1000;
      } else if (toLength == "Mile") {
        result = length / 1.60934;
      } else if (toLength == "Yard") {
        result = length * 1093.61;
      } else {
        result = length;
      }
    } else if (fromLength == "Mile") {
      if (toLength == "Meter") {
        result = length * 1609.34;
      } else if (toLength == "Kilometer") {
        result = length * 1.60934;
      } else if (toLength == "Yard") {
        result = length * 1760;
      } else {
        result = length;
      }
    } else {
      // Yard
      if (toLength == "Meter") {
        result = length / 1.09361;
      } else if (toLength == "Kilometer") {
        result = length / 1093.61;
      } else if (toLength == "Mile") {
        result = length / 1760;
      } else {
        result = length;
      }
    }

    setState(() {
      convertedLength = formatLength(result);
    });
  }

  // Fungsi untuk format angka hasil konversi
  String formatLength(double length) {
    final formatter = NumberFormat("#,##0.##", "en_US");
    return formatter.format(length);
  }

  // Fungsi untuk menambah angka ke input panjang
  void appendNumber(String number) {
    setState(() {
      if (number == "." && inputLength.contains("."))
        return; // Cegah titik ganda
      inputLength += number;
      convertLength();
    });
  }

  // Fungsi untuk membersihkan input
  void clear() {
    setState(() {
      inputLength = "";
      convertedLength = "";
    });
  }

  // Fungsi untuk menghapus karakter terakhir
  void backspace() {
    setState(() {
      if (inputLength.isNotEmpty) {
        inputLength = inputLength.substring(0, inputLength.length - 1);
        convertLength();
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
          'Konversi Panjang',
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
                  // Input Panjang Awal
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
                              value: fromLength,
                              onChanged: (value) {
                                setState(() {
                                  fromLength = value!;
                                  convertLength();
                                });
                              },
                              items: ["Meter", "Kilometer", "Mile", "Yard"]
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
                          inputLength.isEmpty ? "0" : inputLength,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Hasil Konversi Panjang
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
                              value: toLength,
                              onChanged: (value) {
                                setState(() {
                                  toLength = value!;
                                  convertLength();
                                });
                              },
                              items: ["Meter", "Kilometer", "Mile", "Yard"]
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
                          convertedLength.isEmpty ? "0" : convertedLength,
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
                      color: Colors.blueAccent,
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
