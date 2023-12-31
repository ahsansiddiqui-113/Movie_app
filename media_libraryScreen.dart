import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MediaLibraryScreen extends StatefulWidget {
  @override
  _MediaLibraryScreenState createState() => _MediaLibraryScreenState();
}

class _MediaLibraryScreenState extends State<MediaLibraryScreen> {
  final String apiKey = '7e2888cb00457031860b026f0415280c';

  Future<List<MovieCard>> fetchMediaLibrary() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((movie) => MovieCard.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load media library');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieCard>>(
      future: fetchMediaLibrary(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No movies in the media library.');
        } else {
          List<MovieCard> mediaLibrary = snapshot.data!;
          return ListView.builder(
            itemCount: mediaLibrary.length,
            itemBuilder: (context, index) {
              return MovieCardWidget(movieCard: mediaLibrary[index]);
            },
          );
        }
      },
    );
  }
}

class MovieCard {
  final String title;
  final String imageUrl;

  MovieCard({
    required this.title,
    required this.imageUrl,
  });

  factory MovieCard.fromJson(Map<String, dynamic> json) {
    return MovieCard(
      title: json['title'],
      imageUrl: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
    );
  }
}

class MovieCardWidget extends StatelessWidget {
  final MovieCard movieCard;

  MovieCardWidget({required this.movieCard});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Image.network(
          movieCard.imageUrl,
          height: 80,
          width: 60,
          fit: BoxFit.cover,
        ),
        title: Text(movieCard.title),
      ),
    );
  }
}
