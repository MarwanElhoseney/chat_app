import 'package:chat_app/database/my_database.dart';
import 'package:chat_app/model/Room.dart';
import 'package:flutter/material.dart';

abstract class AddRoomNaviegator {
  void showLoading({String message = "loading"});

  void hideDiloug();

  void showMessage(String message, String action);
}

class AddRoomViewModel extends ChangeNotifier {
  AddRoomNaviegator? naviegator;

  void addRoom(String title, String descreption, String catId) async {
    naviegator?.showLoading();
    try {
      var res = await MyDataBase.createRom(
          Room(title: title, descreption: descreption, catId: catId));
      naviegator?.hideDiloug();
      naviegator?.showMessage("room created successfully", "ok");
    } catch (e) {
      naviegator?.hideDiloug();
      naviegator?.showMessage("something went wrong ${e.toString()}", "cancel");
    }
  }
}
