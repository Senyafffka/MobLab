import 'package:flutter/material.dart';
import 'package:my_resume/features/profile/view_model/profile.dart';

class ProfileViewModel extends ChangeNotifier {
  List<String> _incorrectFields = [];
  final _profile = Profile();

  bool isIncorrectFields(String field){
    return _incorrectFields.contains(field);
  }

  void updateProfile(String field, String data) {
    _profile.update(field, data);

    final check = _profile.isFullyFilledOut();

    final correct = check.getOrElse((list){
      _incorrectFields = list;
      return false;
    });

    if(correct){
      //todo сохранение профиля
    }else{
      notifyListeners();
    }
  }
}