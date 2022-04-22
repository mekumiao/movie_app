import 'package:movie_api/movie_api.dart';

class FileRepository {
  const FileRepository({
    required FileApi fileApi,
  }) : _fileApi = fileApi;

  final FileApi _fileApi;

  Future<String> add(String filePath, {String? remark}) {
    return _fileApi.add(filePath, remark: remark);
  }
}
