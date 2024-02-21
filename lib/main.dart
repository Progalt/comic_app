import 'package:comic_app/Backend/comic.dart';
import 'package:comic_app/Pages/comic_page.dart';
import 'package:comic_app/Pages/home.dart';
import 'package:comic_app/Pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

 Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xtycrvingymyxlomqdiw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh0eWNydmluZ3lteXhsb21xZGl3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDgzNjIxNTUsImV4cCI6MjAyMzkzODE1NX0.rKSS9o73qoXaHPRyFSMj6hLq3CLQOX68UzAeu594rXw',
  );


  runApp(const MyApp());
}

ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 32, 32, 32), brightness: Brightness.dark);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Comic App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 32, 32, 32), brightness: Brightness.dark),
        useMaterial3: true,
      ),
      // Batman 143: 76194134182814311
      // Ultimate Spider-Man 1: 75960620796100111
      // Spider-Man 1: 33459
      // Batman 143: 106934
      // Batman 142: 105742
      // Flash (2023) 1: 74612
      // Batman (2011) 2: 6799
      //home: ComicPage(comic: Comic.fromID(74612)),
       //home: const HomePage()
       home: const LoginPage()
    );
  }
}
