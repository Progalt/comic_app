import 'dart:convert';

import 'package:comic_app/Backend/comic_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:comic_app/Backend/series.dart';

class Comic extends ChangeNotifier {

  Comic();

  Comic.fromUPC(String newUPC) {

    ComicDatabase.getFromUPC(newUPC).then((value) { 
        fromComic(value);
        notifyListeners();
      });
  }

  Comic.fromComic(Comic comic) {
    fromComic(comic);
  }

  void fromJSON(Map<String, dynamic> json) {
    coverLink = json["image"];
    coverHash = json["cover_hash"];
    title = json["issue"];
    issueNumber = int.parse(json["number"]);
    coverDate = DateTime.parse(json["cover_date"]);
  }

  void fromComic(Comic comic) {
    loaded = comic.loaded;
    upc = comic.upc;
    title = comic.title;
    coverLink = comic.coverLink;
    issueNumber = comic.issueNumber;
    coverHash = comic.coverHash;
    coverDate = comic.coverDate;
    series = comic.series;
  }

  bool loaded = false;
  String upc = "";
  String title = "";
  String coverLink = "";
  int issueNumber = 0;
  String coverHash = "";
  DateTime coverDate = DateTime.now();

  Series series = Series();
}