import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _input = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      _input = "";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "×" ||
        buttonText == "÷") {
      num1 = double.parse(_output);
      operand = buttonText;
      _input = "";
      _output = "0";
    } else if (buttonText == ".") {
      if (!_input.contains(".")) {
        _input = _input + buttonText;
        _output = _input;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(_output);
      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "×") {
        _output = (num1 * num2).toString();
      }
      if (operand == "÷") {
        _output = (num1 / num2).toString();
      }
      num1 = 0;
      num2 = 0;
      operand = "";
      _input = "";
    } else {
      if (_input.length < 10) {
        _input = _input + buttonText;
        _output = _input;
      }
    }
    setState(() {});
  }

  Widget buildButton(String buttonText, {Color? color, Color? textColor}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Color(0xFFF5F3FF),
            padding: EdgeInsets.all(24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: textColor ?? Colors.pinkAccent,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F3FF),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.pinkAccent),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Calculator',
          style: TextStyle(color: Colors.pinkAccent),
        ),
        backgroundColor: Color(0xFFF5F3FF),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(24.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
            Expanded(child: Divider()),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("÷",
                        color: Colors.pinkAccent, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("×",
                        color: Colors.pinkAccent, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("-",
                        color: Colors.pinkAccent, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("C",
                        color: Colors.pinkAccent, textColor: Colors.white),
                    buildButton("0"),
                    buildButton("."),
                    buildButton("+",
                        color: Colors.pinkAccent, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("=",
                        color: Colors.pinkAccent, textColor: Colors.white),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
