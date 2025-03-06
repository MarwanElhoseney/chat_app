import 'package:chat_app/customs/custom_text_form_field.dart';
import 'package:chat_app/ui/regestretion/RegesterScreen.dart';
import 'package:chat_app/ui/signIn/signIn_ViewModel.dart';
import 'package:chat_app/utiles/dialogs_utils/dilaogs.dart';
import 'package:chat_app/utiles/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class signInScreen extends StatefulWidget {
  static const String routeName = "loginScreen";

  @override
  State<signInScreen> createState() => _signInScreenState();
}

class _signInScreenState extends State<signInScreen>
    implements signInNaviegator {
  var formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  void initState() {
    super.initState();
    viewModel = signInViewModel();
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
                        signIn();
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
      ),
    );
  }

  late signInViewModel viewModel;

  void signIn() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.signIn(emailController.text, passwordController.text);
  }

  @override
  void hideDiloug() {
    DialougUtiles.hideDialougs(context);
  }

  @override
  void showLoading({String message = "loading"}) {
    DialougUtiles.showLoadingDilaogs(context, message);
  }

  void showMessage(String message, String action) {
    if (action == "ok") {
      DialougUtiles.showMessage(
        context,
        message,
        posActionTitles: action,
        posAction: () {
          Navigator.pushReplacementNamed(context, signInScreen.routeName);
        },
      );
    } else if (action == "cancel") {
      DialougUtiles.showMessage(context, message, negActionTitles: action);
    }
  }
}
