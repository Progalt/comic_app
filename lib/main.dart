import 'package:comic_app/Backend/comic.dart';
import 'package:comic_app/Pages/comic_page.dart';
import 'package:comic_app/Pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comic App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 32, 32, 32)),
        useMaterial3: true,
      ),
      // Batman 143: 76194134182814311
      // Ultimate Spider-Man 1: 75960620796100111
      home: ComicPage(comic: Comic.fromUPC("76194134182814311")),
    );
  }
}
