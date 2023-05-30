import '../../src/core/handlers/handlers.dart';
import '../../modify/models/models.dart';

abstract class BaseRepository {
  Future<ApiResult<BaseResponse>> getListBase();
  Future<dynamic> checkDataFolder();
  Future<dynamic> createDataFolder();
}
