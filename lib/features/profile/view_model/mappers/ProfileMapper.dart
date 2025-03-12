import 'package:my_resume/features/profile/view_model/profile.dart' as vm;
import 'package:my_resume/core/domain/profile/profile.dart' as model;

abstract class ProfileMapper{
  model.Profile getProfileForModel(vm.Profile vm){
    final data = vm.data;
    return model.Profile(
      name: data['name']!,
      surname: data['surname']!,
      patronymic: data['patronymic'],
      citizenship: data['citizenship']!,
      email: data['email']!,
      phone: data['phone']!,
      placeOfResidence: data['placeOfResidence']!,
      dateOfBirth: DateTime.parse(data['dateOfBirth']!),
      age: int.parse(data['age']!),
      gender: vm.gender,
      isReadyToTravel: vm.isReadyToTravel,
    );
  }

  vm.Profile getProfileForViewModel(model.Profile m){
    final profile = vm.Profile();

    profile.update('name', m.name);
    profile.update('surname', m.surname);
    profile.update('patronymic', m.patronymic ?? "");
    profile.update('email', m.email);
    profile.update('phone', m.phone);
    profile.update('dateOfBirth', m.dateOfBirth.toString());
    profile.update('age', m.age.toString());
    profile.update('placeOfResidence', m.placeOfResidence);
    profile.update('citizenship', m.citizenship);

    if(profile.gender!=m.gender) profile.changeGender();
    if(profile.isReadyToTravel!=m.isReadyToTravel) profile.changeReady();

    return profile;
  }
}