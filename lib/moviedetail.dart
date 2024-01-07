import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieDetailPage extends StatefulWidget {
  final Map<String, dynamic> movie;

  MovieDetailPage({required this.movie});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late Map<String, dynamic> detailedMovie;

  @override
  void initState() {
    super.initState();
    detailedMovie = widget.movie;
    fetchMovieDetails();
  }

  Future<void> fetchMovieDetails() async {
    final Uri apiUrl = Uri.parse('http://www.omdbapi.com/?apikey=eab96b3b&i=${widget.movie['imdbID']}');

    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      setState(() {
        detailedMovie = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(detailedMovie['Title']),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                detailedMovie['Poster'],
                width: 200.0, // Adjust the width as needed
                height: 300.0, // Adjust the height as needed
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            Text('Year: ${detailedMovie['Year']}'),
            Text('Rated: ${detailedMovie['Rated']}'),
            Text('Released: ${detailedMovie['Released']}'),
            Text('Genre: ${detailedMovie['Genre']}'),
            Text('Director: ${detailedMovie['Director']}'),
            Text('Writer: ${detailedMovie['Writer']}'),
            Text('Actors: ${detailedMovie['Actors']}'),
            Text('Language: ${detailedMovie['Language']}'),
            Text('Country: ${detailedMovie['Country']}'),
            Text('Ratings: ${detailedMovie['Ratings']}'),
            Text('Awards: ${detailedMovie['Awards']}'),
            // Add more information as needed
          ],
        ),
      ),
    );
  }
}
