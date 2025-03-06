import 'package:chat_app/customs/custom_text_form_field.dart';
import 'package:chat_app/ui/regestretion/RegesterScreen.dart';
import 'package:chat_app/utiles/dialogs_utils/dilaogs.dart';
import 'package:chat_app/utiles/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signInScreen extends StatefulWidget {
  static const String routeName = "loginScreen";

  @override
  State<signInScreen> createState() => _signInScreenState();
}

class _signInScreenState extends State<signInScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/background_image.png"))),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 90,
                ),
                CustomTextFormField(
                    text: "email",
                    controller: emailController,
                    validate: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return "Plz enter email";
                      }
                      ;
                      if (!isValidEmail(input)) {
                        return "enter valid email";
                      }
                      ;
                      return null;
                    }),
                CustomTextFormField(
                  text: "password",
                  obscure: true,
                  visable: true,
                  controller: passwordController,
                  validate: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return "Plz enter password";
                    }
                    ;
                    if (input.length < 8) {
                      return "password must be at least 8 chars";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: () {
                      signUp();
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("logIn"),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Regesterscreen.routeName);
                    },
                    child: Text("dont have account?regester")),
              ],
            ),
          )),
    );
  }

  var authService = FirebaseAuth.instance;

  void signUp() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    DialougUtiles.showLoadingDilaogs(context, "loading...");

    authService
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((UserCredential) {
      DialougUtiles.hideDialougs(context);
      DialougUtiles.showMessage(context, UserCredential.user?.uid ?? "",
          posActionTitles: "next");
    }).onError((error, stackTrace) {
      DialougUtiles.hideDialougs(context);
      DialougUtiles.showMessage(context, error.toString(),
          negActionTitles: "ok");
    });
  }
}
