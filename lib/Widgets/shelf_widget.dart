

import 'package:comic_app/Widgets/comic_widget.dart';
import 'package:flutter/material.dart';

class Shelf extends StatelessWidget {

  const Shelf({ super.key, required this.title, required this.shelfItems, this.viewMore });

  final String title; 
  final Function? viewMore; 
  final List<ComicWidget> shelfItems; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              Text(title),
              const Spacer(),
              if (viewMore != null)
                IconButton(onPressed: () => viewMore, icon: const Icon(Icons.arrow_forward))
            ]
          ),

          SizedBox(
            height: 160,
            child: ListView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              children: shelfItems,
            )
          )

        ]
      
      )
    );
  }
}