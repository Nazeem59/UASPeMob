import 'package:flutter/material.dart';
import 'side_menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KabarGempa extends StatefulWidget {
  @override
  _KabarGempaState createState() => _KabarGempaState();
  final String username;

  KabarGempa({required this.username});
}

class _KabarGempaState extends State<KabarGempa> {
  Future<List<dynamic>> fetchData() async {
    try {
      final Uri apiUrl = Uri.parse('https://data.bmkg.go.id/DataMKG/TEWS/gempaterkini.json');

      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body)['Infogempa']['gempa'];

        if (responseData != null) {
          return responseData;
        } else {
          throw Exception('Invalid API response format');
        }
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kabar Gempa Terkini'),
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
      body: FutureBuilder<List<dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<dynamic> dataCollection = snapshot.data!;
            return ListView.builder(
              itemCount: dataCollection.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Magnitude: ${dataCollection[index]['Magnitude']}'),
                  subtitle: Text('Waktu: ${dataCollection[index]['Tanggal']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
