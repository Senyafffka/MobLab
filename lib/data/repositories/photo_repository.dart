import 'dart:typed_data';

import 'package:logger/logger.dart';
import 'package:my_resume/core/domain/repositories/photo_repository.dart';
import 'package:my_resume/data/datasourse/enums/img_type_enum.dart';
import 'package:my_resume/data/datasourse/photo_loader.dart';

class PhotoRepository implements IPhotoRepository{
  PhotoLoader loader = PhotoLoader();

  @override
  Future<Uint8List?> find() async {
    final result = await loader.find();
    return result.getOrElse((error){
      Logger().i('[PhotoRepository - find()] $error');
      return null;
    });
  }

  @override
  Future<bool> save(Uint8List img) async {

    if (img.length < 8) return false; // Минимум для проверки PNG

    // Проверка на PNG (сигнатура: 89 50 4E 47 0D 0A 1A 0A)
    final pngSignature = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A];
    if (img.sublist(0, 8).every((byte) => pngSignature.contains(byte))) {
      return await loader.saveImage(img, ImgType.png);
    }

    // Проверка на JPEG (сигнатура: FF D8 FF)
    final jpegSignature = [0xFF, 0xD8];
    if (img[0] == jpegSignature[0] && img[1] == jpegSignature[1]) {
      return await loader.saveImage(img, ImgType.jpg);
    }

    return false;
  }

}