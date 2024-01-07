import 'package:flutter/material.dart';
import 'package:projek/login.dart';
import 'package:projek/home.dart';
import 'package:projek/registration.dart';
import 'BMI.dart';
import 'package:projek/moviepage.dart';
import 'kabargempa.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projek',
       theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Tentukan halaman awal aplikasi
      routes: {
        '/login': (context) => LoginPage(), // Tentukan rute untuk halaman login
        '/home': (context) => HomePage(username: '',), // Tentukan rute untuk halaman home
        '/registration': (context) => RegistrationPage(), // Tentukan rute untuk halaman registrasi
        '/bmi': (context) => BMICalculatorPage(username: '',),
        '/moviepage': (context) => MovieSearchPage(username: ''),
        '/kabargempa': (context) => KabarGempa(username: ''),
      },
    );
  }
}
