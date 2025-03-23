import 'dart:typed_data';

abstract interface class IPhotoRepository{
  Future<Uint8List?> find();
  Future<String> save(Uint8List img);
}