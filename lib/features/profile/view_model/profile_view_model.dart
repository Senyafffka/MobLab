import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_resume/const/enums/gender_enum.dart';
import 'package:my_resume/core/domain/models/profile_model.dart';
import 'package:my_resume/features/profile/view_model/mappers/ProfileMapper.dart';
import 'package:my_resume/features/profile/view_model/profile.dart';

class ProfileViewModel extends ChangeNotifier {
  List<String> _incorrectFields = [];
  Profile _profile = Profile();
  bool _isSaved = false;
  ProfileModel model = ProfileModel();

  ProfileViewModel(){
    model.profile.then((profile){
      _profile = (profile!=null) ?
          ProfileMapper.getProfileForViewModel(profile) : Profile();
      Logger().i('[model loaded] $_profile');
      notifyListeners();
    });
  }


  bool isIncorrectFields(String field){
    return _incorrectFields.contains(field);
  }

  bool get isSaved{return _isSaved;}
  bool get profileIsReady{return _profile.isReadyToTravel;}
  GenderEnum get profileGender{return _profile.gender;}
  String getField(String tag) => _profile.data[tag] ?? "error";

  Future<void> changeReady() async {
    _profile.changeReady();
    await _checkAndUpdate();
    notifyListeners();
  }

  Future<void> changeGender() async {
    _profile.changeGender();
    await _checkAndUpdate();
    notifyListeners();
  }

  Future<void> updateProfile(String field, String data) async {
    _profile.update(field, data);
    await _checkAndUpdate();
    notifyListeners();
  }

  Future<void> _checkAndUpdate() async {
    final check = _profile.isFullyFilledOut();

    final correct = check.getOrElse((list){
      _incorrectFields = list;
      Logger(printer: PrettyPrinter()).i('[incorrectFields]incorrect fields: $list',);
      return false;
    });

    Logger().i('[new model] $_profile');
    if(correct){
      _isSaved = await model.update(ProfileMapper.getProfileForModel(_profile));
    }else{
      _isSaved = false;
      //notifyListeners();
    }
  }
}