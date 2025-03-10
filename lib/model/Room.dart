class Room {
  static const String collectionName = "room";
  String? title;
  String? id;
  String? catId;
  String? descreption;

  Room({this.id, this.title, this.catId, this.descreption});

  Room.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data["id"],
          descreption: data["descreption"],
          title: data["title"],
          catId: data["catId"],
        );

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "descreption": descreption,
      "title": title,
      "catId": catId,
    };
  }
}
