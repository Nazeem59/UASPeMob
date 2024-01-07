import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'side_menu.dart';
import 'moviedetail.dart'; // Import the movie detail page

class MovieSearchPage extends StatefulWidget {
  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();

  final String username;

  MovieSearchPage({required this.username});
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  List<dynamic> movies = [];
  late String searchQuery;

  @override
  void initState() {
    super.initState();
    searchQuery = '';
  }

  Future<void> fetchMovies() async {
    final Uri apiUrl = Uri.parse('http://www.omdbapi.com/?apikey=eab96b3b&s=$searchQuery');

    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      setState(() {
        movies = json.decode(response.body)['Search'];
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
    fetchMovies();
  }

  void showMovieDetail(Map<String, dynamic> movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieDetailPage(movie: movie)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Search'),
      ),
      drawer: SideMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Search Movies'),
              onSubmitted: (query) {
                updateSearchQuery(query);
            },
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(movies[index]['Title']),
                  subtitle: Text(movies[index]['Year']),
                  onTap: () {
                    showMovieDetail(movies[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
