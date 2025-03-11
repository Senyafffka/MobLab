import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {

  void updateProfile(String field, String data) {

    notifyListeners();
  }
}