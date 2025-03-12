import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_resume/const/enums/gender_enum.dart';
import 'package:my_resume/features/profile/view_model/profile.dart';

class ProfileViewModel extends ChangeNotifier {
  List<String> _incorrectFields = [];
  final _profile = Profile();
  bool _isSaved  = false;


  bool isIncorrectFields(String field){
    return _incorrectFields.contains(field);
  }

  bool get isSaved{return _isSaved;}
  bool get profileIsReady{return _profile.isReadyToTravel;}
  GenderEnum get profileGender{return _profile.gender;}


  void changeReady(){
    _profile.changeReady();
    //todo сохранение
    notifyListeners();
  }

  void changeGender(){
    _profile.changeGender();
    //todo сохранение
    notifyListeners();
  }

  void updateProfile(String field, String data) {
    _profile.update(field, data);

    final check = _profile.isFullyFilledOut();

    final correct = check.getOrElse((list){
      _incorrectFields = list;
      Logger(printer: PrettyPrinter()).i('[incorrectFields]incorrect fields: $list',);

      return false;
    });

    if(correct){
      //todo сохранение профиля
      _isSaved = true;
    }else{
      notifyListeners();
    }
  }
}