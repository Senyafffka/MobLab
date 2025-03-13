import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_resume/const/enums/gender_enum.dart';

part 'profile.freezed.dart';

@freezed
abstract class Profile with _$Profile{
  const factory Profile({
    required String name,
    required String surname,
    String? patronymic,
    required String email,
    required String phone,
    required GenderEnum gender,
    required DateTime dateOfBirth,
    required int age,
    required String placeOfResidence,
    required String citizenship,
    required bool isReadyToTravel,
  }) = $Profile;
}

