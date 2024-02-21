import 'dart:convert';
import 'package:comic_app/Backend/comic_database.dart';
import 'package:comic_app/Backend/creator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:comic_app/Backend/series.dart';

class Variant {
  String upc = "";
  String name = "";
  String coverLink = "";

}

class Comic extends ChangeNotifier {

  Comic();

  GlobalKey key = GlobalKey();

  Comic.fromUPC(String newUPC) {

    ComicDatabase.getIDFromUPC(newUPC).then((value) { 
      ComicDatabase.fromID(value).then((comic) {
        fromComic(comic);
        notifyListeners();
      });
        
    });
  }

  Comic.fromID(int id) {
     ComicDatabase.fromID(id).then((comic) {
        fromComic(comic);
        notifyListeners();
      });
  }

  Comic.fromComic(Comic comic) {
    fromComic(comic);
  }

  void fromJSONPartial(Map<String, dynamic> json) {
    id = json["id"];
    coverHash = json["cover_hash"];
    coverLink = json["image"];

    partial = true; 
  }

  void fromJSON(Map<String, dynamic> json) {
    id = json["id"];
    coverLink = json["image"];
    issueNumber = int.parse(json["number"]);
    coverHash = json["cover_hash"];

    series.fromJSON(json["series"]);

    List<String> names = List.from(json["name"]);
    

    if (names.isNotEmpty) {
      title = names[0];
    }
    else {
      title = series.name;
    }
    issueNumber = int.parse(json["number"]);

    if (json["cover_date"] != null) {
      coverDate = DateTime.parse(json["cover_date"]);
    }
    if (json["store_date"] != null) {
      storeDate = DateTime.parse(json["store_date"]);
    }
    //coverDate = DateTime.parse(json["cover_date"]);
    description = json["desc"].toString();
    pageCount = json["page"];
    dollarStorePrice = double.parse(json["price"]);

  

    // Load varients if we have any
    List<Map<String, dynamic>> variantsList = List.from(json["variants"]);
    

    for (int i = 0; i < variantsList.length; i++) {
      Variant variant = Variant();

      variant.name = variantsList[i]["name"];
      variant.upc = variantsList[i]["upc"];
      variant.coverLink = variantsList[i]["image"];

      print("Found Varient: ${variant.name}");

      variants.add(variant);
    }

    List<Map<String, dynamic>> creatorList = List.from(json["credits"]);

    for (var c in creatorList) {
      Creator creator = Creator();
      creator.id = c["id"];
      creator.name = c["creator"];

      List<Map<String, dynamic>> roleList = List.from(c["role"]);

      List<CreatorRoles> roles = List.generate(roleList.length, (index) {
        switch(roleList[index]["name"]) {
          case "Writer": return CreatorRoles.writer;
          case "Inker": return CreatorRoles.inker;
          case "Letterer": return CreatorRoles.letterer;
          case "Penciller": return CreatorRoles.penciller;
          case "Colorist": return CreatorRoles.colourist;
          case "Editor": return CreatorRoles.editor;
          case "Artist": return CreatorRoles.artist;
          case "Cover": return CreatorRoles.cover;
        }

        return CreatorRoles.unknown;
      });
      
      creators.add((creator, roles));

      print("Creator: ${creator.name} - ${roles.toString()}");
    }

    partial = false; 
  }

  void fromComic(Comic comic) {
    loaded = comic.loaded;
    partial = comic.partial;
    upc = comic.upc;
    title = comic.title;
    coverLink = comic.coverLink;
    issueNumber = comic.issueNumber;
    coverHash = comic.coverHash;
    storeDate = comic.storeDate;
    series = comic.series;
    description = comic.description;
    pageCount = comic.pageCount;
    dollarStorePrice = comic.dollarStorePrice;
    variants = comic.variants;
    creators = comic.creators;
  }

  bool loaded = false;
  bool partial = false; 
  int id = 0; 
  int pageCount = 0;
  double dollarStorePrice = 0.0;
  String upc = "";
  String title = "";
  String coverLink = "";
  int issueNumber = 0;
  String coverHash = "";
  String description = "";
  DateTime storeDate = DateTime.now();
  DateTime coverDate = DateTime.now();

  List<Variant> variants = List.empty(growable: true);
  List<(Creator, List<CreatorRoles>)> creators = List.empty(growable: true); 

  Series series = Series();
}