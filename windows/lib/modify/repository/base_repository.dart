import '../../src/core/handlers/handlers.dart';
import '../../modify/models/models.dart';

abstract class BaseRepository {
  Future<ApiResult<BaseResponse>> getListBase();
  Future<dynamic> checkDataFolder();
  Future<dynamic> createDataFolder();
  Future<dynamic> addEmployee(dynamic dataEmployee);
  Future<dynamic> updateEmployee(dynamic dataEmployee);
  Future<dynamic> deleteEmployee(String email);
  Future<dynamic> checkAccessBlock();
  Future<ApiResult<EmployeeResponse>> getListEmplyees();
}
