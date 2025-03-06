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
      naviegator?.hideDiloug();
      naviegator?.showMessage("logged in succsesfully", "ok");
    } on FirebaseAuthException catch (e) {
      naviegator?.hideDiloug();
      naviegator?.showMessage("wrong email or password", "cancel");
    }
  }
}
