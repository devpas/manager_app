import '../../src/core/handlers/handlers.dart';
import '../../modify/models/models.dart';

abstract class BaseRepository {
  Future<ApiResult<BaseResponse>> getListBase();
  Future<dynamic> checkDataFolder();
  Future<dynamic> createDataFolder(String baseType);
  Future<dynamic> addEmployee(dynamic dataEmployee);
  Future<dynamic> updateEmployee(dynamic dataEmployee);
  Future<dynamic> deleteEmployee(String email);
  Future<dynamic> checkAccessBlock();
  Future<dynamic> getMoneyWallet(String email);
  Future<dynamic> uploadFile(String name, String base64, String fileType);
  Future<dynamic> createTicket(TicketData ticket, int reason);
  Future<ApiResult<EmployeeResponse>> getListEmplyees();
  Future<dynamic> getListPrinters();
  Future<dynamic> addPrinter(dynamic printerData);
  Future<dynamic> updatePrinter(dynamic printerData);
  Future<dynamic> deletePrinter(int printerId);
  Future<dynamic> getListBaseEmployee();
  Future<dynamic> checkExpireFileLargeData();
  Future<dynamic> moneyRecord();
  Future<dynamic> loadDataWhenStartApp();
}
