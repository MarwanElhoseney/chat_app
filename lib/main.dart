import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/ui/regestretion/RegesterScreen.dart';
import 'package:chat_app/ui/signIn/signIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Regesterscreen.routeName: (context) => Regesterscreen(),
        signInScreen.routeName: (context) => signInScreen()
      },
      initialRoute: Regesterscreen.routeName,
    );
  }
}
