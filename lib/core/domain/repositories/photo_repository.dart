import 'dart:typed_data';

abstract interface class IPhotoRepository{
  Future<Uint8List?> find();
  Future<bool> save(Uint8List img);
}