import 'package:flutter/material.dart';
import 'package:openai_appp/movie.dart';
import 'package:openai_appp/utilities.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/*
  //If you're making multiple requests to the same server, you can keep open a
  //persistent connection by using a Client rather than making one-off requests.
  //If you do this, make sure to close the client when you're done:
  var client = http.Client();
  try {
    var response = await client.post(
        Uri.https('example.com', 'whatsit/create'),
        body: {'name': 'doodle', 'color': 'blue'});
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    var uri = Uri.parse(decodedResponse['uri'] as String);
    print(await client.get(uri));
  } finally {
    client.close();
  }
 */
class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List<Movie> movieList = [];

  void getMovies() async {
    String apikey = await readFromAsset("assets/apikeys/api_key_tmdb.txt");
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apikey'));
    if (response.statusCode == 200) {
      setState(() {
        movieList = (json.decode(response.body)['results'] as List)
            .map((data) => Movie.fromJson(data))
            .toList();
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
      body: movieList.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(movieList[index].title ?? "Title"),
              subtitle: Text(movieList[index].releaseDate ?? "Subtitle"),
            ),
          );
        },
      ),
    );
  }
}