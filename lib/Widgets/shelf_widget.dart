

import 'package:comic_app/Widgets/comic_widget.dart';
import 'package:flutter/material.dart';

class Shelf extends StatelessWidget {

  const Shelf({ super.key, required this.title, required this.shelfItems, this.viewMore, this.maxItems = 16 });

  final String title; 
  final Function? viewMore; 
  final List<ComicWidget> shelfItems; 
  final int maxItems; 

  List<ComicWidget> sortedList() {

    List<ComicWidget> widgets = shelfItems.sublist(0, maxItems > shelfItems.length ? shelfItems.length : maxItems);

    widgets.sort((a, b) {
      if (a.comic != null && b.comic != null) {
        return b.comic!.storeDate.compareTo(a.comic!.storeDate);
      }

      return 0;
    });

    return widgets; 
  }

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
            height: 180,
            child: ListView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              children: sortedList()
               ),
            )
          

        ]
      
      )
    );
  }
}