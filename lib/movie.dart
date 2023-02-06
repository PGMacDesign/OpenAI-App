import 'package:flutter/material.dart';


class Movie {
  int? id;
  String? title;
  String? releaseDate;

  Movie({this.id, this.title, this.releaseDate});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      releaseDate: json['release_date'],
    );
  }
}