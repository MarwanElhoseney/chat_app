import 'package:chat_app/database/my_database.dart';
import 'package:chat_app/sharedData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class signInNaviegator {
  void showLoading({String message = "loading"});

  void hideDiloug();

  void showMessage(String message, String action);
}

class signInViewModel extends ChangeNotifier {
  var authService = FirebaseAuth.instance;
  signInNaviegator? naviegator;

  void signIn(email, password) async {
    try {
      naviegator?.showLoading();
      var credintial = await authService.signInWithEmailAndPassword(
          email: email, password: password);
      var retrivedUser = await MyDataBase.getUserById(credintial.user!.uid);
      if (retrivedUser == null) {
        naviegator?.showMessage("wrong email or password", "cancel");
      } else {
        SharedData.user = retrivedUser;
        naviegator?.hideDiloug();
        naviegator?.showMessage("logged in succsesfully", "ok");
      }
    } on FirebaseAuthException catch (e) {
      naviegator?.hideDiloug();
      naviegator?.showMessage("wrong email or password", "cancel");
    }
  }
}
