import 'package:chat_app/customs/custom_text_form_field.dart';
import 'package:chat_app/ui/home_screen/home_screen.dart';
import 'package:chat_app/ui/regestretion/regester_view_model.dart';
import 'package:chat_app/ui/signIn/signIn.dart';
import 'package:chat_app/ui/signIn/signIn_ViewModel.dart';
import 'package:chat_app/utiles/dialogs_utils/dilaogs.dart';
import 'package:chat_app/utiles/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Regesterscreen extends StatefulWidget {
  static const String routeName = "regesterScreen";

  @override
  State<Regesterscreen> createState() => _RegesterscreenState();
}

class _RegesterscreenState extends State<Regesterscreen>
    implements regesterNaviegator {
  var formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  late regesterViewModel viewModel;

  void initState() {
    super.initState();
    viewModel = regesterViewModel();
    viewModel.naviegator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/background_image.png"))),
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text("Regester Screen"),
            ),
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
                      controller: fNameController,
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
                      controller: lNameController,
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
                              context, SignInScreen.routeName);
                        },
                        child: Text("Already have account?signIn")),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void signUp() {
    if (formKey.currentState?.validate() == false) {
      return;
    }

    viewModel.regester(emailController.text, passwordController.text,
        fNameController.text, lNameController.text);
  }

  @override
  void hideDiloug() {
    DialougUtiles.hideDialougs(context);
  }

  @override
  void showLoading({String message = "loading"}) {
    DialougUtiles.showLoadingDilaogs(context, message);
  }

  @override
  void showMessage(String message, String action) {
    if (action == "ok") {
      DialougUtiles.showMessage(
        context,
        message,
        posActionTitles: action,
        posAction: () {
          Navigator.pushReplacementNamed(context, SignInScreen.routeName);
        },
      );
    } else if (action == "cancel") {
      DialougUtiles.showMessage(context, message, negActionTitles: action);
    }
  }
}
