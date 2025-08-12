import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadHelper {
  /// Downloads a file from [url] and saves it to the device's Downloads directory.
  /// Returns the file path if successful, or throws an error.
  static Future<String> downloadFile(String url, {String? fileName}) async {
    // Request storage permission
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      throw Exception('Storage permission not granted');
    }

    Directory? downloadsDir;
    if (Platform.isAndroid) {
      downloadsDir = Directory('/storage/emulated/0/Download');
      if (!downloadsDir.existsSync()) {
        downloadsDir = await getExternalStorageDirectory();
      }
    } else {
      downloadsDir = await getApplicationDocumentsDirectory();
    }
    if (downloadsDir == null) throw Exception('Could not access download directory');

    final String name = fileName ?? url.split('/').last;
    final String savePath = '${downloadsDir.path}/$name';

    final dio = Dio();
    await dio.download(url, savePath);
    return savePath;
  }
}
