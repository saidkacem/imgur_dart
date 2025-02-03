/// This script provides command-line interface (CLI) commands for interacting with Imgur API.
///
/// ## Upload an Image:
/// To upload an image to Imgur, use the following command:
/// ```sh
/// dart run bin/imgur_cli.dart upload path/to/your/image.jpg
/// ```
/// Replace `path/to/your/image.jpg` with the actual path to the image you want to upload.
///
/// ## Delete an Image:
/// To delete an image from Imgur, use the following command:
/// ```sh
/// dart run bin/imgur_cli.dart delete your_delete_hash
/// ```
/// Replace `your_delete_hash` with the delete hash of the image you want to delete.
///
/// ## Download an Image:
/// To download an image from Imgur, use the following command:
/// ```sh
/// dart run bin/imgur_cli.dart download your_image_id path/to/save/image.jpg
/// ```
/// Replace `your_image_id` with the ID of the image you want to download and `path/to/save/image.jpg` with the path where you want to save the downloaded image.

import 'package:imgur_dart/imgur_dart.dart';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('Usage: dart run bin/imgur_cli.dart [upload|delete|download] <args>');
    return;
  }

  final imgur = ImgurAPI(
    clientId: 'your_client_id',
    accessToken: 'your_access_token',
  );

  switch (arguments[0]) {
    case 'upload':
      if (arguments.length < 2) {
        print('Usage: dart run bin/imgur_cli.dart upload <image_path>');
        return;
      }
      String? url = await imgur.uploadImage(arguments[1]);
      print(url != null ? 'Uploaded: $url' : 'Upload failed.');
      break;

    case 'delete':
      if (arguments.length < 2) {
        print('Usage: dart run bin/imgur_cli.dart delete <delete_hash>');
        return;
      }
      bool success = await imgur.deleteImage(arguments[1]);
      print(success ? 'Deleted successfully.' : 'Delete failed.');
      break;

    case 'download':
      if (arguments.length < 3) {
        print('Usage: dart run bin/imgur_cli.dart download <image_id> <save_path>');
        return;
      }
      String? path = await imgur.downloadImage(arguments[1], arguments[2]);
      print(path != null ? 'Downloaded to $path' : 'Download failed.');
      break;

    default:
      print('Unknown command. Use: upload, delete, or download.');
  }
}
