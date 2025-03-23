

import 'dart:io';
import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:my_resume/data/datasourse/enums/img_type_enum.dart';
import 'package:my_resume/data/datasourse/functions/convert_img_type_to_string_function.dart';
import 'package:my_resume/data/datasourse/image_compressor/image_compressor.dart';
import 'package:path_provider/path_provider.dart';

class PhotoLoader{
  late File filePng;
  late File fileJpg;
  bool _pngExists = false;
  bool _jpgExists = false;

  Future<bool> get pngExists async {
    _pngExists = await filePng.exists();
    return _pngExists;
  }

  Future<bool> get jpgExists async {
    _jpgExists = await filePng.exists();
    return _jpgExists;
  }

  Future<Either<String,Uint8List?>> find() async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final filePng = File('${directory.path}/img.png');
      final fileJpg = File('${directory.path}/img.jpg');

      if (await jpgExists || await pngExists) {
        if(_jpgExists)return Either.right(await fileJpg.readAsBytes());
        if(_pngExists)return Either.right(await filePng.readAsBytes());
      }
      return Either.left('not found');
    } catch (e) {
      return Either.left(e.toString());
    }
  }

  Future<String> saveImage(Uint8List imageData, ImgType type) async {
    try {
      String error = "";
      final directory = await getApplicationDocumentsDirectory();
      final typeStr = ConvertImgTypeToStringFunction.body(type);

      final request= await ImageCompressor.compress(imageData, typeStr);

      Uint8List? compressed = request.getOrElse((str){
        error = str;
        return null;
      });

      final file = File('${directory.path}/img$typeStr');
      await file.writeAsBytes(compressed ?? imageData);

      return error;
    } catch (e) {
      return e.toString();
    }
  }
}