//import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_resume/const/enums/gender_enum.dart';
import 'package:my_resume/core/domain/models/profile_model.dart';
import 'package:my_resume/features/profile/view_model/mappers/ProfileMapper.dart';
import 'package:my_resume/features/profile/view_model/profile.dart';

class ProfileViewModel extends ChangeNotifier {
  List<String> _incorrectFields = [];
  Profile _profile = Profile();
  String savedStatus = "";
  bool _isSaved = false;
  bool _isLoadingPhoto = false;
  ProfileModel model = ProfileModel();

  var currentCorrectMessage = 0;
  var currentIncorrectMessage = 0;

  final messagesIfIncorrect = [
    'Поля заполнены неправильно',
    'Некорректный ввод',
  ];

  final messagesIfCorrect = [
    'Успешно сохранено!',
    'Я всё сохранил',
    'Данные сохранены'
  ];

  ProfileViewModel() {
    model.profile.then((profile) {
      _profile = (profile != null)
          ? ProfileMapper.getProfileForViewModel(profile)
          : Profile();
      notifyListeners();
    });
  }

  bool isIncorrectFields(String field) {
    return _incorrectFields.contains(field);
  }

  bool get isSaved {
    return _isSaved;
  }

  bool get profileIsReady {
    return _profile.isReadyToTravel;
  }

  GenderEnum get profileGender {
    return _profile.gender;
  }

  bool get isLoadingPhoto{ return _isLoadingPhoto;}

  String getField(String tag) => _profile.getField(tag);

  Uint8List? get img {
    return _profile.img;
  }

  void openPhotoLoader() {
    _isLoadingPhoto = true;
    notifyListeners();
  }

  void closePhotoLoader() {
    _isLoadingPhoto = false;
    notifyListeners();
  }

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

  Future<void> installPhoto(Uint8List img) async {
    _profile.img = img;
    _checkAndUpdate();
  }

  Future<void> updateProfile(String field, String data) async {
    _profile.update(field, data);
    await _checkAndUpdate();
    print(_incorrectFields);
    notifyListeners();
  }

  Future<void> _checkAndUpdate() async {
    final check = _profile.isFullyFilledOut();

    final correct = check.getOrElse((list) {
      _incorrectFields = list;
      return false;
    });
    if (correct) {
      _incorrectFields = [];
      savedStatus= await model.update(ProfileMapper.getProfileForModel(_profile));

      if(savedStatus.isEmpty){
        savedStatus = messagesIfCorrect[currentCorrectMessage];
        currentIncorrectMessage++;
        if(messagesIfCorrect.length == currentCorrectMessage) currentCorrectMessage = 0;
        _isSaved = true;
      }
    } else {
      savedStatus = messagesIfIncorrect[currentIncorrectMessage];
      currentIncorrectMessage++;
      if(messagesIfIncorrect.length == currentIncorrectMessage) currentIncorrectMessage = 0;
      _isSaved = false;
      //notifyListeners();
    }

    Logger().i('[savedStatus] $savedStatus');
  }
}
