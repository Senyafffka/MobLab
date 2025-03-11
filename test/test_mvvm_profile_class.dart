import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_resume/features/profile/view_model/profile.dart';

void main(){
  final profile = Profile();

  test('Проверка на валидность сразу после инициализации', (){
    Either<List<String>, bool> valid = profile.isFullyFilledOut();
    expect(true, valid.isLeft());
    List<String> incorrect = [];
    valid.getOrElse((list){
      incorrect = list; return false;
    });

    expect([
      'name',
      'surname',
      'patronymic',
      'email',
      'phone',
      'gender',
      'dateOfBirth',
      'age',
      'placeOfResidence',
      'citizenship',
      'isReadyToTravel'
    ], incorrect);
  });

  test('Правильно заполненный пользователь', (){
    profile.data['name'] = 'Иван';
    profile.data['surname'] = 'Иванов';
    profile.data['patronymic'] = 'Иванович';
    profile.data['email'] = 'ivan@gmail.com';
    profile.data['phone'] = '89991232323';
    profile.data['dateOfBirth'] = '01.01.2003';
    profile.data['gender'] = 'man';
    profile.data['age'] = '25';
    profile.data['placeOfResidence'] = 'г Томск ул Федора-Лыткина д 12 кв 123';
    profile.data['isReadyToTravel'] = '1';
    profile.data['citizenship'] = 'РФ';
    expect(true, profile.isFullyFilledOut().isRight());
  });

  test('проверка даты', (){
    profile.data['dateOfBirth'] = '89991232323';
    expect(true, profile.isFullyFilledOut().isLeft());

    profile.data['dateOfBirth'] = '31.02.2024';
    expect(true, profile.isFullyFilledOut().isLeft(), reason: 'високосный год');

    profile.data['dateOfBirth'] = '12.02.2024';
    expect(false, profile.isFullyFilledOut().isLeft(), reason: 'правильный формат');
  });

  test('проверка почты', (){
    profile.data['email'] = '@ivan.com';
    expect(true, profile.isFullyFilledOut().isLeft());

    profile.data['email'] = 'ivan@g.com';
    expect(false, profile.isFullyFilledOut().isLeft(), reason: 'правильный формат');
  });

  test('проверка телефона', (){
    profile.data['phone'] = '+7 998 898 89 89';
    expect(true, profile.isFullyFilledOut().isRight(), reason: 'правильный номер (+7)');

    profile.data['phone'] = '8 998 898 89 89';
    expect(true, profile.isFullyFilledOut().isRight(), reason: 'правильный номер (8)');

    profile.data['phone'] = '8 (998) 898-89-89';
    expect(true, profile.isFullyFilledOut().isRight(), reason: 'правильный номер (со знаками)');

    profile.data['phone'] = '12345';
    expect(false, profile.isFullyFilledOut().isRight(), reason: 'неправильный номер');
  });

}