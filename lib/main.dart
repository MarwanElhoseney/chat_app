import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/ui/add_room/add_room.dart';
import 'package:chat_app/ui/home_screen/home_screen.dart';
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
        SignInScreen.routeName: (context) => SignInScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddRoom.routeName: (context) => AddRoom(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
