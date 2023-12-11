import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WatchScreen extends StatefulWidget {
  @override
  _WatchScreenState createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  final String apiKey = '7e2888cb00457031860b026f0415280c';
  final String movieDetailsUrl = 'https://api.themoviedb.org/3/movie/<1>';
  final String movieImagesUrl = 'https://api.themoviedb.org/3/movie/<1>/images';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Movie list
        Positioned.fill(
          child: FutureBuilder(
            future: _fetchMovies(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Replace with your actual movie list widget
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final movie = snapshot.data;
                    return _MovieCard(movie as Movie);
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        // Search bar
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            width: 50,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Implement search functionality
                  print('Search clicked');
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<List<Movie>> _fetchMovies() async {
    // Replace with actual API request to fetch movie data
    final response =
        await http.get(Uri.parse(movieDetailsUrl + '?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'].map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to fetch movies');
    }
  }
}

class Movie {
  final String title;
  final String posterPath;

  Movie({required this.title, required this.posterPath});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      posterPath: json['https://api.themoviedb.org/3/movie'],
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Movie movie;

  const _MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          // Display movie poster image
          Image.network(
            'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
            width: 100,
            height: 150,
          ),
          SizedBox(width: 16),
          Text(
            movie.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
