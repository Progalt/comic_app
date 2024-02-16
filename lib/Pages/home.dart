
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comics"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_cart)),
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
                shelfItems: const [
                  ComicWidget(),
                  ComicWidget(),
                  ComicWidget(),
                  ComicWidget(),
                  ComicWidget(),
                ],
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