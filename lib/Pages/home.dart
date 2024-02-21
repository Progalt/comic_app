
import 'package:comic_app/Backend/comic.dart';
import 'package:comic_app/Backend/comic_database.dart';
import 'package:comic_app/Widgets/carosel_widget.dart';
import 'package:comic_app/Widgets/comic_widget.dart';
import 'package:comic_app/Widgets/shelf_widget.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  List<Comic> comics = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    ComicDatabase.arc(177).then((value) {
      setState(() {
        comics = value; 
      });
    });
  } 



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comics"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.photo_camera)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.person))
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              //const CaroselWidget(),

              Shelf(
                shelfItems: List.generate(comics.length, (index) {
                  return ComicWidget(key: comics[index].key, comic: comics[index]);
                }),
                title: "New Releases",
                viewMore: () {},
              ),
            ],
          )
        )
      )
    );
  }
}