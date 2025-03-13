import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'profile_json.freezed.dart';
part 'profile_json.g.dart';

@freezed
abstract class ProfileJson with _$ProfileJson{
  const factory ProfileJson({
    required String name,
    required String surname,
    String? patronymic,
    required String email,
    required String phone,
    required String gender,
    required String dateOfBirth,
    required int age,
    required String placeOfResidence,
    required String citizenship,
    required bool isReadyToTravel,
  }) = _ProfileJson;

  factory ProfileJson.fromJson(Map<String, dynamic> json) => _$ProfileJsonFromJson(json);
}