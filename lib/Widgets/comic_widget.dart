

import 'package:comic_app/Backend/comic.dart';
import 'package:comic_app/Backend/comic_database.dart';
import 'package:comic_app/Pages/comic_page.dart';
import 'package:flutter/material.dart';

class ComicWidget extends StatelessWidget {

  const ComicWidget({ super.key, this.comic });

  final Comic? comic; 

  @override
  Widget build(BuildContext context) {
    if (comic == null) {
      return Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: AspectRatio(
          aspectRatio: 6.625 / 10.187,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade600,
            ),

            child: const Center(
              child: Icon(Icons.image, color: Colors.white)
            )
          ),
        )
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: AspectRatio(
        aspectRatio: 6.625 / 10.187, 
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () { 
            ComicDatabase.fromID(comic!.id).then((value) {
              Navigator.push(context, MaterialPageRoute(builder:(context) {
              return ComicPage(comic: value);
            })); });
          
          },
          child: Ink(
            width: 140, 

            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              
              image: DecorationImage(
                fit: BoxFit.contain,
                image: Image.network(comic!.coverLink).image)
            ),
  
          )
        )
      )
    );
    

  }
}