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
    profile.update('name', 'Иван');
    profile.update('surname', 'Иванов');
    profile.update('patronymic', 'Иванович');
    profile.update('email', 'ivan@gmail.com');
    profile.update('phone', '89991232323');
    profile.update('dateOfBirth', '01.01.2003');
    profile.update('age', '33');
    profile.update('placeOfResidence', 'г Томск ул Федора-Лыткина д 12 кв 123');
    profile.update('citizenship', 'РФ');
    expect(true, profile.isFullyFilledOut().isRight());
  });

  test('проверка даты', (){
    profile.update('dateOfBirth', '89991232323');
    expect(true, profile.isFullyFilledOut().isLeft());

    profile.update('dateOfBirth', '31.02.2024');
    expect(true, profile.isFullyFilledOut().isLeft(), reason: 'високосный год');

    profile.update('dateOfBirth', '12.02.2024');
    expect(false, profile.isFullyFilledOut().isLeft(), reason: 'правильный формат');
  });

  test('проверка почты', (){
    profile.update('email', '@ivan.com');
    expect(true, profile.isFullyFilledOut().isLeft());

    profile.update('email', 'ivan@g.com');
    expect(false, profile.isFullyFilledOut().isLeft(), reason: 'правильный формат');
  });

  test('проверка телефона', (){
    profile.update('phone', '+7 998 898 89 89');
    expect(true, profile.isFullyFilledOut().isRight(), reason: 'правильный номер (+7)');

    profile.update('phone', '8 998 898 89 89');
    expect(true, profile.isFullyFilledOut().isRight(), reason: 'правильный номер (8)');

    profile.update('phone', '8 (998) 898-89-89');
    expect(true, profile.isFullyFilledOut().isRight(), reason: 'правильный номер (со знаками)');

    profile.update('phone', '12345');
    expect(false, profile.isFullyFilledOut().isRight(), reason: 'неправильный номер');
  });

}