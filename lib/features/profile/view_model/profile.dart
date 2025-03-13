import 'package:fpdart/fpdart.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:my_resume/const/enums/gender_enum.dart';

class Profile{
  final Map<String,String> _data = {
    "name" : "",
    "surname": "",
    "patronymic": "",
    "email": "",
    "phone": "",
    "dateOfBirth": "",
    "age": "",
    "placeOfResidence": "",
    "citizenship": "",
  };

  Map<String,String> get data{return _data;}
  bool _isReadyToTravel = true;
  GenderEnum _gender = GenderEnum.man;

  bool get isReadyToTravel{return _isReadyToTravel;}
  GenderEnum get gender{return _gender;}

  void changeGender() => _gender = (_gender == GenderEnum.man)? GenderEnum.woman : GenderEnum.man;
  void changeReady() => _isReadyToTravel = !_isReadyToTravel;

  void update(String field, String info){
    if(_data[field] == null){
      throw Exception('Нет поля $field');
    }
    
    if(
    (field == 'dateOfBirth' && _checkDate(info)) || 
        (field == 'age' && _checkDate(_data['dateOfBirth']!))
    ) {
      if(field == 'dateOfBirth') _data[field] = info;

      DateTime date1 = DateTime.now();
      DateTime date2 = DateFormat('dd.MM.yyyy').parseStrict(data['dateOfBirth']!);

      int years = date1.year - date2.year;

      if (date2.month < date1.month || (date2.month == date1.month && date2.day < date1.day)) {
        years--;
      }
      Logger().i('[age] $years');
      _data['age'] = years.toString();
    } else {
      _data[field] = info;
    }
  }

  List<String> get allFieldNames {return _data.keys.toList();}

  Either<List<String>, bool> isFullyFilledOut(){
    final incorrectFields = <String>[];
    for(final field in _data.keys){
      if(_data[field]==null){
        throw Exception('$field in profile (VM) is null');
      } else{
        if(_data[field]!.isEmpty) incorrectFields.add(field);
      }
    }

    if(incorrectFields.contains('dateOfBirth') &&  !incorrectFields.contains('age')){
      incorrectFields.add('age');
    }

    if(!incorrectFields.contains('age')){
      final age = int.tryParse(_data['age']!);
      if(age == null) incorrectFields.add('age');
    }

    if(!incorrectFields.contains('dateOfBirth') && !_checkDate(_data['dateOfBirth']!)){
      incorrectFields.add('dateOfBirth');
      if(!incorrectFields.contains('age')){
        incorrectFields.add('age');
      }
    }
    
    if(!incorrectFields.contains('email') && !_checkEmail(_data['email']!)){
      incorrectFields.add('email');
    }

    if(!incorrectFields.contains('phone') && !_checkPhoneNumber(_data['phone']!)){
      incorrectFields.add('phone');
    }

    return incorrectFields.isEmpty ?
      Either<List<String>, bool>.right(true) :
      Either<List<String>, bool>.left(incorrectFields);
  }

  bool _checkDate(String date){
    final RegExp dateRegex = RegExp(r'^(0[1-9]|[12][0-9]|3[01])\.(0[1-9]|1[0-2])\.\d{4}$');
    if(!dateRegex.hasMatch(date)) return false;
    
    try {
      DateFormat('dd.MM.yyyy').parseStrict(date);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool _checkEmail(String email){
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',);
    return emailRegex.hasMatch(email);
  }

  bool _checkPhoneNumber(String phone) {
    final RegExp phoneRegex = RegExp(
      r'^\+?[0-9]{1,4}?[-.\s]?\(?[0-9]{1,4}?\)?[-.\s]?[0-9]{1,4}[-.\s]?[0-9]{1,4}[-.\s]?[0-9]{1,4}$',
    );
    int countNum = 0;

    for(int i=0;i<phone.length;i++) {
      if(int.tryParse(phone[i]) != null) countNum++;
    }

    if(countNum > 15 || countNum < 7) return false;

    return phoneRegex.hasMatch(phone);
  }
}

