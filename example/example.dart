/// This script runs the Dart example located at `example/example.dart`.
///
/// To execute the script, use the following command:
///
/// ```sh
/// dart run example/example.dart
/// ```
///
/// Make sure you are in the root directory of your project when running this command.

import 'package:imgur_dart/imgur_dart.dart';

void main() async {
  final imgur = ImgurAPI(
    clientId: 'your_client_id',
    accessToken: 'your_access_token',
  );

  // Upload
  String? uploadedUrl = await imgur.uploadImage('example/image.jpg');
  print('Uploaded Image URL: $uploadedUrl');

  // Delete
  bool isDeleted = await imgur.deleteImage('your_delete_hash');
  print('Image deleted: $isDeleted');

  // Download
  String? downloadedPath = await imgur.downloadImage('your_image_id', 'example/downloaded.jpg');
  print('Downloaded Image Path: $downloadedPath');
}
