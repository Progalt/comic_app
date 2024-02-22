

import 'package:supabase_flutter/supabase_flutter.dart';

class AppUser {

  Future<bool> signInWithPassword(String email, String password) async {

    final AuthResponse response = await Supabase.instance.client.auth.signInWithPassword(
      email: email, 
      password: password
    );

    if (response.user == null || response.session == null) {
      return false; 
    }

    supabaseUser = response.user; 
    supabaseSession = response.session; 

    print("Signed in user: ${supabaseUser!.email!}");

    return true; 
  }

  void signOut() {
    Supabase.instance.client.auth.signOut();
  }

  // Returns if the comic is currently within the users comic collection 
  bool isComicInCollection(int id, { int variant = 0 }) {
    return comicFake.containsKey("$id + $variant"); 
  }

  void addComicToCollection(int id, int variant) {
    comicFake["$id + $variant"] = true; 
  }

  Map<String, bool> comicFake = {}; 

  Session? supabaseSession; 
  User? supabaseUser; 
}

AppUser appUser = AppUser(); 