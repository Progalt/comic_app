

import 'package:supabase_flutter/supabase_flutter.dart';

class AppUser {

  void signInWithPassword(String email, String password) {

  }

  // Returns if the comic is currently within the users comic collection 
  bool isComicInCollection(int id, { int variant = 0 }) {
    return false; 
  }

  void addComicToCollection(int id, int variant) {
    
  }

  Session? supabaseSession; 
  User? supabaseUser; 
}

AppUser appUser = AppUser(); 