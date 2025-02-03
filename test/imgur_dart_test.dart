/// This is the main entry point for running Dart tests in the Imgur Dart project.
///
/// To execute the tests, use the following command:
/// ```
/// dart test
/// ```
///
/// Make sure you are in the correct directory where the `imgur_dart_test.dart` file is located.

import 'package:imgur_dart/imgur_dart.dart';
import 'package:test/test.dart';

void main() {
  final imgur = ImgurAPI(
    clientId: 'your_client_id',
    accessToken: 'your_access_token',
  );

  test('Upload Image', () async {
    final result = await imgur.uploadImage('test/test_image.jpg');
    expect(result, isNotNull);
  });

  test('Delete Image', () async {
    final result = await imgur.deleteImage('your_delete_hash');
    expect(result, isTrue);
  });

  test('Download Image', () async {
    final result = await imgur.downloadImage('your_image_id', 'test/downloaded.jpg');
    expect(result, isNotNull);
  });
}
