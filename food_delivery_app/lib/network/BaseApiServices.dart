// ignore_for_file: file_names

import 'dart:io';

abstract class BaseApiServices {
  Future<dynamic> getMultipartApiResponse(String url, List<File> files,
      {String? name, List<double>? coordinates});
}
