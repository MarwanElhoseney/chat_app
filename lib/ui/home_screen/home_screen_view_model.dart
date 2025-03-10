import 'package:flutter/material.dart';

abstract class homeScreenNaviegator {}

class homeScreenViewModel extends ChangeNotifier {
  homeScreenNaviegator? naviegator;
}
