import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  bool isSwitched = false;

  void toggleSwitch() {
    isSwitched = !isSwitched;
    notifyListeners();
  }
}