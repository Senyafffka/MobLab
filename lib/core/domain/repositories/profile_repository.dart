import 'package:fpdart/fpdart.dart';
import 'package:my_resume/core/domain/entities/profile/profile.dart';

abstract interface class IProfileRepository{
  Future<Profile?> find();
  Future<bool> save(Profile profile);
}