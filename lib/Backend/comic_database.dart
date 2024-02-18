

import 'dart:convert';

import 'package:comic_app/Backend/comic.dart';
import 'package:comic_app/Backend/creator.dart';
import 'package:http/http.dart' as http;

class ComicDatabase {

  static Map<int, Comic> comicCache = {}; 
  static Map<String, int> upcToIDTable = {};

  static Map<int, Creator> creatorDb = {};

  static var headers = {
    'Authorization': 'Basic UHJvZ2FsdDpwNyxlWF5HbjVVbWNLImY=',
    'Content-Type': 'application/json'
  };

  static Future<int> getIDFromUPC(String newUPC) async {

    waitUntilQueryAvailable();

    incrementQuery();

    if (upcToIDTable.containsKey(newUPC)) {
      print("Retrieved UPC to ID cached");
      return upcToIDTable[newUPC]!;
    }

    String queryLoc = "https://metron.cloud/api/issue/?upc=$newUPC";

    var request = http.Request("GET", Uri.parse(queryLoc));
    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode != 200) {
      print("Server Response was not 200");
      return 0; 
    }

    Map<String, dynamic> json = jsonDecode(await response.stream.bytesToString());

    Map<String, dynamic> issue = json["results"][0];

    int id = issue["id"];

    upcToIDTable[newUPC] = id; 

    return id;
  }

  static Future<Comic> fromID(int id) async {

    waitUntilQueryAvailable();

    incrementQuery();

    Comic comic = Comic(); 
    // See if the comic is cached
    if (comicCache.containsKey(id)) {
      print("Getting Comic from cache");
      comic.fromComic(comicCache[id]!);

      // If the comic is partially loaded we want to then load it fully
      if (!comic.partial) {
        return comic;
      }
      else {
        comic = Comic();
      }
    }

    // If we do a from UPC we want to query it from the API

    String queryLoc = "https://metron.cloud/api/issue/$id/";

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

    comic.fromJSON(json);

    comic.loaded = true;
    comicCache[id] = comic; 

    return comic; 
  }

  static Future<List<Comic>> fromDate(DateTime from, DateTime? to) async {
    String fromStr = "${from.year}-${from.month}-${from.day}";
    String toStr = "";

    bool twoPoints = false;

    if (to != null) {
      twoPoints = true; 
      toStr = "${to.year}-${to.month}-${to.day}";
    }

    String query = "https://metron.cloud/api/issue/";

    if (twoPoints) {
      query += "?store_date_range_after=$fromStr&store_date_range_before=$toStr";
    } 
    else {
      query += "?store_date=$fromStr";
    }


    return queryComics(query);
  }

  static Future<List<Comic>> fromSeries(int seriesId) async {
     String query = "https://metron.cloud/api/issue/?series_id=$seriesId";

    return queryComics(query);
  }

  static Future<List<Comic>> seriesAfterDate(int seriesId, String dateString) {
    String query = "https://metron.cloud/api/issue/?series_id=$seriesId&store_date_range_after=$dateString";

    return queryComics(query);
  }

  static Future<List<Comic>> queryComics(String query) async {

    waitUntilQueryAvailable();

    incrementQuery();

    print("Query: $query");
    var request = http.Request("GET", Uri.parse(query));
    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode != 200) {
      print("Server Response was not 200");
      return List.empty(); 
    }

    Map<String, dynamic> json = jsonDecode(await response.stream.bytesToString());

    int count = json["count"];

    if (count >= 100) {
      count = 99;
    }

    print("Found $count Comics between dates");


    if (count == 0) {
      return List.empty(); 
    }

   
    List<Comic> comics = List.empty(growable: true);

    for (int i = 0; i < count; i++) {
      Map<String, dynamic> comicJson = json["results"][i];

      Comic comic = Comic();
      comic.fromJSONPartial(comicJson);

      comic.loaded = true;
      comicCache[comic.id] = comic; 

      comics.add(comic);
    }

    return comics; 
  }

  static int queryCount = 0;
  static const int maxQueriesPerMinute = 30;

  static bool canQuery() {
    return queryCount < maxQueriesPerMinute;
  }

  static void waitUntilQueryAvailable() {
    print("Current Query Count: $queryCount");
    if (!canQuery()) {
      print("Waiting for query to be available");
    }
    while(!canQuery()) {

    }
  }

  static void incrementQuery() {
    queryCount++;
    Future.delayed(const Duration(minutes: 1)).then((value) => queryCount--);
  }

}
