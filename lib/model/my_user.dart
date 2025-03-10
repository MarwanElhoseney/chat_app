class MyUser {
  static const String collectionName = "users";
  String? fName;
  String? lName;
  String? id;
  String? email;

  MyUser({this.id, this.email, this.fName, this.lName});

  MyUser.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data["id"],
          fName: data["fName"],
          lName: data["lName"],
          email: data["email"],
        );

  Map<String, dynamic> toFireStore() {
    return {
      "fName": fName,
      "lName": lName,
      "id": id,
      "email": email,
    };
  }
}
