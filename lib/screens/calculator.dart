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

  Widget buildButton(String buttonText, {bool isOperator = false}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(6.0),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            backgroundColor: isOperator ? Colors.pink[50] : Colors.black,
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.w400,
              color: isOperator ? Colors.pink[300] : Colors.pink[200],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.pink[200]),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                alignment: Alignment.bottomRight,
                child: Text(
                  _output,
                  style: TextStyle(
                    fontSize: 64.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.pink[300],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        buildButton("C", isOperator: true),
                        buildButton("÷", isOperator: true),
                        buildButton("×", isOperator: true),
                        buildButton("⌫", isOperator: true),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        buildButton("7"),
                        buildButton("8"),
                        buildButton("9"),
                        buildButton("-", isOperator: true),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        buildButton("4"),
                        buildButton("5"),
                        buildButton("6"),
                        buildButton("+", isOperator: true),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        buildButton("1"),
                        buildButton("2"),
                        buildButton("3"),
                        buildButton("%", isOperator: true),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        buildButton("."),
                        buildButton("0"),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.all(6.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.all(20.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                backgroundColor: Colors.pink[100],
                              ),
                              onPressed: () => buttonPressed("="),
                              child: Text(
                                "=",
                                style: TextStyle(
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
