class RoomCategoty {
  String? id;
  String? name;
  String? image;

  RoomCategoty({required this.id, required this.name, required this.image});

  static List<RoomCategoty> getAllCategories() {
    return [
      RoomCategoty(
          id: "music", name: "Music", image: "assets/images/music.png"),
      RoomCategoty(
          id: "movies", name: "Movies", image: "assets/images/movies.png"),
      RoomCategoty(
          id: "sports", name: "Sports", image: "assets/images/sports.png"),
    ];
  }
}
