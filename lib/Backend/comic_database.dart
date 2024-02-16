

import 'dart:convert';

import 'package:comic_app/Backend/comic.dart';
import 'package:http/http.dart' as http;

class ComicDatabase {

  static Map<String, Comic> comicCache = {}; 

  // Queries the API from UPC number
  static Future<Comic> getFromUPC(String newUPC) async {
    Comic comic = Comic(); 
    // See if the comic is cached
    if (comicCache.containsKey(newUPC)) {
      print("Getting Comic from cache");
      comic.fromComic(comicCache[newUPC]!);

      return comic;
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

    var response = await request.send();

    if (response.statusCode != 200) {
      print("Server Response was not 200");
      return comic; 
    }

    Map<String, dynamic> json = jsonDecode(await response.stream.bytesToString());

    // Test if we get any comic book data from the query
    // if (int.parse(json["count"]) == 0) {
    //   print("Query returned 0 comics");
    //   return; 
    // }

    Map<String, dynamic> issue = json["results"][0];

    print("Issue: ${issue["issue"]}");
    comic.upc = newUPC;
    comic.fromJSON(issue);

    comic.loaded = true;

    comicCache[newUPC] = comic; 

    return comic; 
    
  }
}
