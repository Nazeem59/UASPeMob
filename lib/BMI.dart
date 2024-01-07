import 'package:flutter/material.dart';
import 'side_menu.dart';


class BMICalculatorPage extends StatefulWidget {
  @override
  _BMICalculatorPageState createState() => _BMICalculatorPageState();

  final String username;

  BMICalculatorPage({required this.username});
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double bmiResult = 0.0;

  void calculateBMI() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double bmi = weight / (height * height);
    setState(() {
      bmiResult = bmi;
    });

    String classification = '';
  if (bmi < 16) {
    classification = 'Severe Thinness';
  } else if (bmi >= 16 && bmi < 17) {
    classification = 'Moderate Thinness';
  } else if (bmi >= 17 && bmi < 18.5) {
    classification = 'Mild Thinness';
  } else if (bmi >= 18.5 && bmi < 25) {
    classification = 'Normal';
  } else if (bmi >= 25 && bmi < 30) {
    classification = 'Overweight';
  } else if (bmi >= 30 && bmi < 35) {
    classification = 'Obese Class 1';
  } else if (bmi >= 35 && bmi < 40) {
    classification = 'Obese Class 2';
  } else {
    classification = 'Obese Class 3';
  }

    // Menampilkan hasil BMI dalam popup (AlertDialog)
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('BMI Result'),
          content: Text('Your BMI: $bmiResult\nClassification: $classification'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.person),
            onSelected: (choice) {
              if (choice == 'profile') {
                Navigator.pushReplacementNamed(context, '/profile');
              } else if (choice == 'logout') {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'profile',
                  child: Text('Profile'),
                ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      drawer: SideMenu(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Weight (kg)'),
            ),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Height (cm)'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                calculateBMI();
              },
              child: Text('Calculate BMI'),
            ),
          ],
        ),
      ),
    );
  }
}
