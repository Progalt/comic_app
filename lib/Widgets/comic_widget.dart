

import 'package:comic_app/Backend/comic.dart';
import 'package:flutter/material.dart';

class ComicWidget extends StatelessWidget {

  const ComicWidget({ super.key, this.comic });

  final Comic? comic; 

  @override
  Widget build(BuildContext context) {
    if (comic == null) {
      return Padding(
        padding: const EdgeInsets.only(right: 3.0),
        child: AspectRatio(
          aspectRatio: 633.0 / 1024.0,
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

    return Container();
  }
}