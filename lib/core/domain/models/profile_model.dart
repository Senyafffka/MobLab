import 'package:logger/logger.dart';
import 'package:my_resume/core/domain/entities/profile/profile.dart';
import 'package:my_resume/core/domain/repositories/profile_repository.dart';
import 'package:my_resume/data/repositories/profile_repository.dart';

class ProfileModel{
  factory ProfileModel() {
    return _singleton;
  }
  IProfileRepository repository = ProfileRepository();
  Profile? _profile;
  static final ProfileModel _singleton = ProfileModel._internal();

  Future<Profile?> get profile async{
    if(_profile!=null) return _profile;
    return _find();
  }

  Future<bool> update(Profile profile) async{
    Logger().i('[profile in update model] ${profile.toString()}');
    return await repository.save(profile);
  }

  Future<Profile?> _find() async {
    return await repository.find();
  }

  ProfileModel._internal();

}