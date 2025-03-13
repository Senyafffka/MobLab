import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:my_resume/data/datasourse/profile_json.dart';
import 'package:path_provider/path_provider.dart';

class ProfileLoader{
  Future<Either<String,ProfileJson?>> find() async {
    try {
      final file = await _localFile();
      if (await file.exists()) {
        final contents = await file.readAsString();
        Map<String, dynamic> profileMap = jsonDecode(contents);
        return Either.right(ProfileJson.fromJson(profileMap));
      } else {
        return Either.left('not found');
      }
    } catch (e) {
      return Either.left(e.toString());
    }
  }

  Future<String?> save(ProfileJson pj) async {
    try{
      final json = pj.toJson();
      final file = await _localFile();
      if(!await file.exists()) await file.create();
      await file.writeAsString(jsonEncode(json));

      return null;
    } catch(e){
      return e.toString();
    }
  }

  Future<File> _localFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    Logger().i('[path to profile] $path');
    return File('$path/profile.json');
  }
}