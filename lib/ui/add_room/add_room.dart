import 'package:chat_app/customs/custom_text_form_field.dart';
import 'package:chat_app/ui/add_room/add_room_view_model.dart';
import 'package:chat_app/ui/add_room/room_categoty.dart';
import 'package:chat_app/ui/home_screen/home_screen.dart';
import 'package:chat_app/ui/home_screen/home_screen_view_model.dart';
import 'package:chat_app/ui/regestretion/regester_view_model.dart';
import 'package:chat_app/utiles/dialogs_utils/dilaogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoom extends StatefulWidget {
  static const String routeName = "AddRoom";

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> implements AddRoomNaviegator {
  late AddRoomViewModel viewModel;
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descreptionController = TextEditingController();

  void initState() {
    super.initState();
    viewModel = AddRoomViewModel();
    viewModel.naviegator = this;
    SelectedRoomCategory = allCats[0];
  }

  List<RoomCategoty> allCats = RoomCategoty.getAllCategories();
  late RoomCategoty SelectedRoomCategory;

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
                  title: Text("Add Room"),
                ),
                extendBody: false,
                backgroundColor: Colors.transparent,
                body: Card(
                  margin: EdgeInsets.all(25),
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Add Room",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Image.asset("assets/images/create_room.png"),
                          CustomTextFormField(
                            text: "Room Name",
                            controller: titleController,
                            validate: (input) {
                              if (input == null || input.trim().isEmpty) {
                                return "Plz enter Room name";
                              }
                            },
                          ),
                          DropdownButton(
                              value: SelectedRoomCategory,
                              items: allCats.map((cat) {
                                return DropdownMenuItem<RoomCategoty>(
                                    value: cat,
                                    child: Row(
                                      children: [
                                        Image.asset("${cat.image}",
                                            width: 40, height: 40),
                                        Text(cat.name ?? ""),
                                      ],
                                    ));
                              }).toList(),
                              onChanged: (item) {
                                if (item == null) return;
                                setState(() {
                                  SelectedRoomCategory = item;
                                });
                              }),
                          CustomTextFormField(
                            text: "Room Description",
                            controller: descreptionController,
                            validate: (input) {
                              if (input == null || input.trim().isEmpty) {
                                return "Plz enter Room descreption";
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                crete();
                              },
                              child: Text(
                                "Create",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ))));
  }

  void crete() {
    if (formKey.currentState?.validate() == false) return;

    viewModel.addRoom(titleController.text, descreptionController.text,
        SelectedRoomCategory.id ?? "");
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
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        },
      );
    } else if (action == "cancel") {
      DialougUtiles.showMessage(context, message, negActionTitles: action);
    }
  }
}
