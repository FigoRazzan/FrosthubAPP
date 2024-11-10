import 'package:flutter/material.dart';

class TemperatureConversionPage extends StatefulWidget {
  @override
  _TemperatureConversionPageState createState() =>
      _TemperatureConversionPageState();
}

class _TemperatureConversionPageState extends State<TemperatureConversionPage> {
  String fromTemperature = "Celsius";
  String toTemperature = "Fahrenheit";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Konversi Suhu")),
      body: Column(
        children: [
          DropdownButton<String>(
            value: fromTemperature,
            items: ["Celsius", "Fahrenheit", "Kelvin"].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                fromTemperature = newValue!;
              });
            },
          ),
          DropdownButton<String>(
            value: toTemperature,
            items: ["Celsius", "Fahrenheit", "Kelvin"].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                toTemperature = newValue!;
              });
            },
          ),
          // Tambahkan widget konversi suhu di sini
        ],
      ),
    );
  }
}
