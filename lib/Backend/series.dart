
class Series {
  Series();

  int id = 0;
  String name = "";
  int volume = 0;
  int yearBegan = 0;
  int type = 0; // Type is like if its ongoing or finished 


  void fromJSON(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    volume = json["volume"];
  }

  List<String> comics = List.empty(growable: true);
}