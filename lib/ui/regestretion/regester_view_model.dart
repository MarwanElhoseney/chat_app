import 'package:chat_app/database/my_database.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/sharedData.dart';
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

  void regester(
      String email, String password, String fName, String lName) async {
    naviegator?.showLoading();
    try {
      var credential = await authService.createUserWithEmailAndPassword(
          email: email, password: password);
      MyUser newUser = MyUser(
        fName: fName,
        lName: lName,
        id: credential.user?.uid,
        email: email,
      );
      var insertedUser = await MyDataBase.insertUser(newUser);
      naviegator?.hideDiloug();
      if (insertedUser != null) {
        SharedData.user = insertedUser;
        naviegator?.showMessage("regestered successfully", "ok");
      } else {
        naviegator?.showMessage("something went wrong", "cancel");
      }
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