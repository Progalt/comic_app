
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Series {

  Series();

  String name = ""; 
  int volumn = 0;
  int yearBegan = 0;

  List<String> comics = List.empty(growable: true); 
}

class Comic extends ChangeNotifier {

  Comic.fromUPC(String newUPC) {

    if (cachedComics.containsKey(newUPC)) {
      print("Getting Comic from cache");
      fromComic(cachedComics[newUPC]!);

      return;
    }


    // If we do a from UPC we want to query it from the API 

    var headers = {
      'Authorization': 'Basic UHJvZ2FsdDpwNyxlWF5HbjVVbWNLImY=',
      'Content-Type': 'application/json'
    };

    String queryLoc = "https://metron.cloud/api/issue/?upc=$newUPC";

    print("Query: $queryLoc");

    var request = http.Request("GET", Uri.parse(queryLoc));
    request.headers.addAll(headers); 

    request.send().then((response) async {
      Map<String, dynamic> json =  jsonDecode(await response.stream.bytesToString());

      Map<String, dynamic> issue = json["results"][0];

     

      print("Issue: ${issue["issue"]}");
      upc = newUPC; 
      coverLink = issue["image"];
      title = issue["issue"];

      loaded = true; 
      cachedComics[upc] = this; 
      notifyListeners();
    });
  }

  Comic.fromComic(Comic comic) {
    fromComic(comic);
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

Map<String, Comic> cachedComics = {}; 