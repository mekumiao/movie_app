import 'models/models.dart';

abstract class UserSearchHistoryApi {
  Future<List<UserSearchHistoryDto>> getList({
    int? no,
    int? size,
    String? q,
    String? tag,
    bool? distinct,
  });

  Future<int> delete(String tag, {String? value});
}
