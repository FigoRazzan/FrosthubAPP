import 'package:flutter/material.dart';

class BmiPage extends StatefulWidget {
  @override
  _BmiPageState createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  String selectedGender = '';
  double height = 170.0;
  double weight = 65.0;
  int age = 25;
  double bmi = 0;
  String bmiStatus = '';
  bool isResultVisible = false;

  void calculateBMI() {
    double heightInMeter = height / 100;
    double bmiValue = weight / (heightInMeter * heightInMeter);
    String status = '';

    // Perbedaan interpretasi BMI berdasarkan gender
    if (selectedGender == 'MALE') {
      if (bmiValue < 18.5) {
        status = 'UNDERWEIGHT';
      } else if (bmiValue >= 18.5 && bmiValue < 24.9) {
        status = 'NORMAL';
      } else if (bmiValue >= 25 && bmiValue < 29.9) {
        status = 'OVERWEIGHT';
      } else {
        status = 'OBESE';
      }
    } else if (selectedGender == 'FEMALE') {
      if (bmiValue < 18.5) {
        status = 'UNDERWEIGHT';
      } else if (bmiValue >= 18.5 && bmiValue < 24.0) {
        status = 'NORMAL';
      } else if (bmiValue >= 24.0 && bmiValue < 29.0) {
        status = 'OVERWEIGHT';
      } else {
        status = 'OBESE';
      }
    }

    setState(() {
      bmi = bmiValue;
      bmiStatus = status;
      isResultVisible = true;
    });
  }

  Widget _buildGenderCard(String gender, IconData icon) {
    bool isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () => setState(() => selectedGender = gender),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(255, 123, 129, 239)
              : Color(0xFF111328),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              gender,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              if (!isResultVisible) ...[
                // Gender Selection
                Row(
                  children: [
                    Expanded(child: _buildGenderCard('MALE', Icons.male)),
                    SizedBox(width: 10),
                    Expanded(child: _buildGenderCard('FEMALE', Icons.female)),
                  ],
                ),
                SizedBox(height: 20),

                // Height Slider
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF1D1E33),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'HEIGHT',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            height.toStringAsFixed(1),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'cm',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
                          thumbColor: Color(0xFFEB1555),
                          overlayColor: Color(0x29EB1555),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 15),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 30),
                        ),
                        child: Slider(
                          value: height,
                          min: 120,
                          max: 220,
                          onChanged: (value) {
                            setState(() => height = value);
                            height = (value * 2).round() / 2;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Weight and Age
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFF1D1E33),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'WEIGHT',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              weight.toStringAsFixed(1),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  heroTag: "weight-",
                                  mini: true,
                                  backgroundColor: Color(0xFF4C4F5E),
                                  child: Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() => weight = weight - 0.5);
                                  },
                                ),
                                SizedBox(width: 10),
                                FloatingActionButton(
                                  heroTag: "weight+",
                                  mini: true,
                                  backgroundColor: Color(0xFF4C4F5E),
                                  child: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() => weight = weight + 0.5);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFF1D1E33),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'AGE',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              age.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  heroTag: "age-",
                                  mini: true,
                                  backgroundColor: Color(0xFF4C4F5E),
                                  child: Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() => age--);
                                  },
                                ),
                                SizedBox(width: 10),
                                FloatingActionButton(
                                  heroTag: "age+",
                                  mini: true,
                                  backgroundColor: Color(0xFF4C4F5E),
                                  child: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() => age++);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                // Result Section
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF1D1E33),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Your Result',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        bmiStatus,
                        style: TextStyle(
                          color:
                              bmiStatus == 'NORMAL' ? Colors.green : Colors.red,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        bmi.toStringAsFixed(1),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Normal BMI range:',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '18.5 to 24.9 kg/m²',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        bmiStatus == 'NORMAL'
                            ? 'You have a normal body weight. Good job!'
                            : 'Your BMI is not in the normal range. Consider consulting a healthcare provider.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: 20),

              // Calculate Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 123, 129, 239),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    isResultVisible ? 'RE-CALCULATE' : 'CALCULATE',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (!isResultVisible) {
                      calculateBMI();
                    } else {
                      setState(() {
                        isResultVisible = false;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
