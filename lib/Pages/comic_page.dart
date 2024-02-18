

import 'package:carousel_slider/carousel_slider.dart';
import 'package:comic_app/Backend/comic.dart';
import 'package:comic_app/Backend/creator.dart';
import 'package:comic_app/Widgets/carosel_widget.dart';
import 'package:flutter/material.dart';

class ComicPage extends StatefulWidget {
  const ComicPage({ super.key, required this.comic });

  final Comic comic; 

  @override 
  State<ComicPage> createState() => ComicPageState();
}

class ComicPageState extends State<ComicPage> {

 
  bool descExpanded = false; 
  int selectedVarient = 0; 

  String getRolesString(List<CreatorRoles> roles) {
    String out = "";

    for (var i in roles) {
      out += rolesToString(i);

      if (i != roles[roles.length - 1]) {
        out += ", ";
      }
    }

    return out; 
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: widget.comic, builder:(context, child) {
      return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: Text("${widget.comic.series.name} #${widget.comic.issueNumber}"),
        ),
        body: widget.comic.loaded == false ? const Center(child: CircularProgressIndicator()) : 
        SingleChildScrollView(child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              if (widget.comic.variants.isEmpty)
                SizedBox(
                  width: 300, 
                  child: ClipRRect( 
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      widget.comic.coverLink,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) { return child; }

                        return AspectRatio(
                          aspectRatio: 6.625 / 10.187,
                          child: Container(
                            color: Colors.grey.shade600,
                            child: const Center(child: CircularProgressIndicator())
                          )
                        );
                      },
                    )
                  )
                ),

              if (widget.comic.variants.isNotEmpty)
                SizedBox(
                
                  //width: 300,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 6.625 / 10.187,
                      height: 470,
                      enlargeCenterPage: false,
                      enlargeFactor: 0.25,
                      clipBehavior: Clip.none,
                      onPageChanged: (index, reason) {
                        setState(() {
                          selectedVarient = index; 
                        });
                        
                      },
                    ),
                    items: List.generate(widget.comic.variants.length + 1, (index) {
                      return ClipRRect( 
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          index == 0 ? widget.comic.coverLink : widget.comic.variants[index - 1].coverLink,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) { return child; }

                            return AspectRatio(
                              aspectRatio: 21.0 / 29.0,
                              child: Container(
                                color: Colors.grey.shade600,
                                child: const Center(child: CircularProgressIndicator())
                              )
                            );
                          },
                        )
                      );
                    })
                  ),
                ),

              const SizedBox(height: 4.0),

              if (widget.comic.variants.isNotEmpty)
                Text(selectedVarient == 0 ? "Main Cover" : widget.comic.variants[selectedVarient - 1].name),

              if (widget.comic.variants.isNotEmpty)
                Center( child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.comic.variants.length + 1, (index) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(selectedVarient == index ? 0.9 : 0.4)),
                      );
                }))),

              const SizedBox(height: 8.0),

              SizedBox(
                width: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${widget.comic.series.name} (vol. ${widget.comic.series.volume}) #${widget.comic.issueNumber}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                            Text(widget.comic.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          ],
                        ),

                        const Spacer(), 

                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: IconButton(onPressed: (){}, icon: Icon(Icons.add)),
                        )
                      ],
                    ),
                   

                    const SizedBox(height: 6.0),

                    Row(children: [
                      Expanded(child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Store Date:", style: TextStyle(fontSize: 12)),
                             Text("${widget.comic.storeDate.day}/${widget.comic.storeDate.month}/${widget.comic.storeDate.year}", 
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                          ],
                        )
                      )),

                      const SizedBox(width: 4.0),

                      Expanded(child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Cover Date:", style: TextStyle(fontSize: 12)),
                             Text("${widget.comic.coverDate.day}/${widget.comic.coverDate.month}/${widget.comic.coverDate.year}", 
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                          ],
                        )
                      )),
                    ],),

                    const SizedBox(height: 4.0),

                    Row(children: [
                      

                      Expanded(child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Cover Price:", style: TextStyle(fontSize: 12)),
                             Text("\$${widget.comic.dollarStorePrice}", 
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                          ],
                        )
                      )),

                      const SizedBox(width: 4.0),

                      Expanded(child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Page Count:", style: TextStyle(fontSize: 12)),
                             Text("${widget.comic.pageCount}", 
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                          ],
                        )
                      ))
                    ],),

                    const SizedBox(height: 4.0),

                    Container(
                      width: double.infinity, 
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(15.0)
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.comic.description, overflow: TextOverflow.fade)
                    ),

                    const SizedBox(height: 4.0),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(15.0)
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                           const Text("Credits:", style: TextStyle(fontSize: 12)),
                           const SizedBox(height: 4.0)

                        ] + List.generate(widget.comic.creators.length, (index) {
                          (Creator, List<CreatorRoles>) credit = widget.comic.creators[index]; 
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context).colorScheme.background
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(credit.$1.name, style: const TextStyle(fontSize: 16)),
                                    Text(getRolesString(credit.$2), style: const TextStyle(fontSize: 12))
                                  ],
                                )
                              )
                            )
                          );
                        }),
                      ),
                    ),


                    const SizedBox(height: 32.0),
                  ],
                )
              )

            

              //Text(comic.description)
            ]
          )
          )
        ));
      }
    );
  }
}