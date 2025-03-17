//import 'package:logger/logger.dart';
import 'package:my_resume/core/domain/entities/profile/profile.dart';
import 'package:my_resume/core/domain/repositories/photo_repository.dart';
import 'package:my_resume/core/domain/repositories/profile_repository.dart';
import 'package:my_resume/data/repositories/photo_repository.dart';
import 'package:my_resume/data/repositories/profile_repository.dart';

class ProfileModel{
  factory ProfileModel() {
    return _singleton;
  }
  IProfileRepository profileJsonRep = ProfileRepository();
  IPhotoRepository photoRep = PhotoRepository();
  Profile? _profile;
  static final ProfileModel _singleton = ProfileModel._internal();

  Future<Profile?> get profile async{
    if(_profile!=null) return _profile;
    return _find();
  }

  Future<bool> update(Profile profile) async{
    if(profile.img!=null) photoRep.save(profile.img!);

    return await profileJsonRep.save(profile);

  }

  Future<Profile?> _find() async {
    var result = await profileJsonRep.find();
    if(result!=null){
      result = result.copyWith(img: await photoRep.find());
    }
    return result;
  }

  ProfileModel._internal();

}