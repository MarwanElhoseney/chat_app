import 'package:chat_app/customs/custom_text_form_field.dart';
import 'package:chat_app/ui/signIn/signIn.dart';
import 'package:chat_app/utiles/dialogs_utils/dilaogs.dart';
import 'package:chat_app/utiles/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Regesterscreen extends StatefulWidget {
  static const String routeName = "regesterScreen";

  @override
  State<Regesterscreen> createState() => _RegesterscreenState();
}

class _RegesterscreenState extends State<Regesterscreen> {
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
          extendBody: false,
          backgroundColor: Colors.transparent,
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250,
                  ),
                  CustomTextFormField(
                    text: "first name",
                    validate: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return "Plz enter full name";
                      }
                      if (input.length < 2) {
                        return "name must br 2 chars";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    text: "last name",
                    validate: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return "Plz enter full name";
                      }
                      if (input.length < 2) {
                        return "name must be 2 chars";
                      }
                      return null;
                    },
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
                  CustomTextFormField(
                    text: "confirm password",
                    obscure: true,
                    visable: true,
                    controller: confirmPasswordController,
                    validate: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return "Plz enter password";
                      }
                      if (input.length < 8) {
                        return "password must be at least 8 chars";
                      }
                      if (input != passwordController.text) {
                        return "password not match";
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
                        child: Text("Regester"),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, signInScreen.routeName);
                      },
                      child: Text("Already have account?signIn")),
                ],
              ),
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
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((UserCredential) {
      DialougUtiles.hideDialougs(context);
      DialougUtiles.showMessage(context, UserCredential.user?.uid ?? "",
          posActionTitles: "next", posAction: () {
        Navigator.pushReplacementNamed(context, signInScreen.routeName);
      });
    }).onError((error, stackTrace) {
      DialougUtiles.hideDialougs(context);
      DialougUtiles.showMessage(context, error.toString(),
          negActionTitles: "ok");
    });
  }
}
