import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

abstract class regesterNaviegator {
  void showLoading({String message = "loading"});

  void hideDiloug();

  void showMessage(String message, String action);
}

class regesterViewModel extends ChangeNotifier {
  regesterNaviegator? naviegator;

  var authService = FirebaseAuth.instance;

  void regester(String email, String password) async {
    naviegator?.showLoading();
    try {
      var credential = await authService.createUserWithEmailAndPassword(
          email: email, password: password);
      naviegator?.hideDiloug();
      naviegator?.showMessage("regestered successfully", "ok");
    } on FirebaseAuthException catch (e) {
      naviegator?.hideDiloug();
      if (e.code == "weak-password") {
        naviegator?.showMessage("the password is too weak", "cancel");
      } else if (e.code == "email-already-in-use") {
        naviegator?.showMessage("email already in use", "cancel");
      }
    } catch (e) {
      naviegator?.hideDiloug();
      naviegator?.showMessage("something went wrong", "cancel");
    }
  }
}