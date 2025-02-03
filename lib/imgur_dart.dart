library imgur_api;

import 'package:dio/dio.dart';

/// A class that provides methods to interact with the Imgur API.
///
/// The `ImgurAPI` class allows you to upload, delete, and download images
/// using the Imgur API.
///
/// Example usage:
/// ```dart
/// final imgur = ImgurAPI(clientId: 'your_client_id', accessToken: 'your_access_token');
/// final uploadResult = await imgur.uploadImage('path_to_image');
/// if (uploadResult != null) {
///   print('Image uploaded: ${uploadResult['link']}');
/// }
/// ```
///
/// Properties:
/// - `clientId`: The client ID for the Imgur API.
/// - `accessToken`: The access token for the Imgur API.
///
/// Methods:
/// - `uploadImage(String imagePath)`: Uploads an image to Imgur and returns a map containing the image link and delete hash.
/// - `deleteImage(String deleteHash)`: Deletes an image from Imgur using the delete hash and returns a boolean indicating success.
/// - `downloadImage(String imageId, String savePath)`: Downloads an image from Imgur using the image ID and saves it to the specified path.
class ImgurAPI {
  final String clientId;
  final String accessToken;
  final Dio _dio = Dio();

  ImgurAPI({required this.clientId, required this.accessToken}) {
    _dio.options.baseUrl = 'https://api.imgur.com/3/';
    _dio.options.headers = {
      'Authorization': 'Bearer $accessToken',
    };
  }

  Future<String?> uploadImage(String imagePath) async {
    try {
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath),
      });
      Response response = await _dio.post('image', data: formData);
      return response.data['data']['link'];
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }

  Future<bool> deleteImage(String deleteHash) async {
    try {
      Response response = await _dio.delete('image/$deleteHash');
      return response.data['success'];
    } catch (e) {
      print('Delete error: $e');
      return false;
    }
  }

  Future<String?> downloadImage(String imageId, String savePath) async {
    try {
      Response response = await _dio.get('image/$imageId');
      String imageUrl = response.data['data']['link'];
      await _dio.download(imageUrl, savePath);
      return savePath;
    } catch (e) {
      print('Download error: $e');
      return null;
    }
  }
}
