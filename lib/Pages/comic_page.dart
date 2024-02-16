

import 'package:comic_app/Backend/comic.dart';
import 'package:flutter/material.dart';

class ComicPage extends StatelessWidget {

  const ComicPage({ super.key, required this.comic });

  final Comic comic; 

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: comic, builder:(context, child) {
      return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(comic.title),
        ),
        body: comic.loaded == false ? const Center(child: CircularProgressIndicator()) : Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              SizedBox(
                width: 300, 
                child: ClipRRect( 
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(comic.coverLink)
                )
              ),

              Text(comic.title),
              Text("Issue Number: ${comic.issueNumber}"),
              Text("Date: ${comic.coverDate.day}/${comic.coverDate.month}/${comic.coverDate.year}")
            ]
          )
          )
        );
      }
    );
  }
}