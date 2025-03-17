import 'package:my_resume/data/datasourse/enums/img_type_enum.dart';

abstract class ConvertImgTypeToStringFunction{
  static Map<ImgType, String> mapConverter = {
    ImgType.jpg : '.jpg',
    ImgType.png : '.png'
  };

  static String body(ImgType type){
    final result = mapConverter[type];
    if(result == null) throw Exception('ConvertImgTypeToStringFunction : нет изображения формата $type');
    return result;
  }
}