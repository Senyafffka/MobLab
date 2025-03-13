import 'package:intl/intl.dart';
import 'package:my_resume/const/enums/gender_enum.dart';
import 'package:my_resume/core/domain/entities/profile/profile.dart';
import 'package:my_resume/data/datasourse/profile_json.dart';

abstract class ProfileMapper{
  static Profile fromData(ProfileJson pj){
    return Profile(
        name: pj.name,
        surname: pj.surname,
        patronymic: pj.patronymic,
        email: pj.email,
        phone: pj.phone,
        gender: pj.gender == 'man' ? GenderEnum.man : GenderEnum.woman,
        dateOfBirth: DateFormat('dd.MM.yyyy').parseStrict(pj.dateOfBirth),
        age: pj.age,
        placeOfResidence: pj.placeOfResidence,
        citizenship: pj.citizenship,
        isReadyToTravel: pj.isReadyToTravel
    );
  }

  static ProfileJson toData(Profile p){
    return ProfileJson(
        name: p.name,
        surname: p.surname,
        email: p.email,
        phone: p.phone,
        gender: p.gender == GenderEnum.man ? 'man' : 'woman',
        dateOfBirth: '${p.dateOfBirth.day}.${p.dateOfBirth.month}.${p.dateOfBirth.year}',
        age: p.age,
        placeOfResidence: p.placeOfResidence,
        citizenship: p.citizenship,
        isReadyToTravel: p.isReadyToTravel
    );
  }
}

