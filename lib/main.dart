import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        backgroundColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.blue,
        ),
      ),
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double bmiResult = 0.0;
  String bmiCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Height (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Weight (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateBMI();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                onPrimary: Colors.white,
              ),
              child: Text('Calculate BMI'),
            ),
            SizedBox(height: 20),
            Text(
              'BMI: ${bmiResult.toStringAsFixed(1)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Category: $bmiCategory',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: getTextColorForCategory(bmiCategory),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0.0;
    double weight = double.tryParse(weightController.text) ?? 0.0;

    if (height > 0 && weight > 0) {
      double heightInMeters = height / 100;
      double bmi = weight / (heightInMeters * heightInMeters);

      String category = getBMICategory(bmi);

      setState(() {
        bmiResult = bmi;
        bmiCategory = category;
      });
    } else {
      // Handle invalid input
      setState(() {
        bmiResult = 0.0;
        bmiCategory = '';
      });
    }
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return 'Normal Weight';
    } else if (bmi >= 25.0 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  Color getTextColorForCategory(String category) {
    switch (category) {
      case 'Underweight':
        return Colors.blue; // Change color as needed
      case 'Normal Weight':
        return Colors.green; // Change color as needed
      case 'Overweight':
        return Colors.orange; // Change color as needed
      case 'Obese':
        return Colors.red; // Change color as needed
      default:
        return Colors.black;
    }
  }
}
