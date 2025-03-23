import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:my_resume/const/config/image_compressor.dart';

class ImageCompressor {

  static Future<Uint8List?> compress(Uint8List imageBytes, String type) async {
    try {
      final dio = Dio();

      final authHeader = 'Basic ${base64Encode(utf8.encode('api:${ImageCompressorConfig.keyAPI} '))}';

      final response = await dio.post(
        ImageCompressorConfig.keyURL,
        data: imageBytes,
        options: Options(
          headers: {
            'Authorization': authHeader,
            'Content-Type': 'image/$type',
          },
        ),
      );

      if (response.statusCode == 201) {
        final jsonResponse = response.data;
        final outputUrl = jsonResponse['output']['url'];

        final compressedResponse = await dio.get(
          outputUrl,
          options: Options(responseType: ResponseType.bytes),
        );

        return compressedResponse.data;
      } else {
        print('Ошибка при сжатии изображения: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Исключение: $e');
      return null;
    }
  }
}