import 'package:logger/logger.dart';
import 'package:my_resume/core/domain/entities/profile/profile.dart';
import 'package:my_resume/core/domain/repositories/profile_repository.dart';
import 'package:my_resume/data/datasourse/profile_loader.dart';
import 'package:my_resume/data/repositories/mappers/profile_mapper.dart';

class ProfileRepository implements IProfileRepository{
  final loader = ProfileLoader();

  @override
  Future<Profile?> find() async {
    final result = await loader.find();
    String? error;

    final profileJson = result.getOrElse((str){
      error = str;
      return null;
    });

    if(error!=null){
      Logger().i('[error] ProfileRepository in find() : $error');
      return null;
    }

    return ProfileMapper.fromData(profileJson!);
  }

  @override
  Future<String> save(Profile profile) async {
    final result = await loader.save(ProfileMapper.toData(profile));

    if(result != null){
      Logger().i('[error] ProfileRepository in find() : $result');
      return result;
    }
    return "";
  }

}