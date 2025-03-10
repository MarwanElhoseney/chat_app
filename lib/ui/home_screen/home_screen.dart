import 'package:chat_app/ui/add_room/add_room.dart';
import 'package:chat_app/ui/home_screen/home_screen_view_model.dart';
import 'package:chat_app/ui/regestretion/regester_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    implements homeScreenNaviegator {
  late homeScreenViewModel viewModel;

  void initState() {
    super.initState();
    viewModel = homeScreenViewModel();
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
                  title: Text("Home Screen"),
                ),
                extendBody: false,
                backgroundColor: Colors.transparent,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AddRoom.routeName);
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.blue,
                        ),
                      ],
                    )
                  ],
                ))));
  }
}
