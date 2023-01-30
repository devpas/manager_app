import '../core/constants/constants.dart';
import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class UsersRepository {
  Future<ApiResult<UsersPaginateResponse>> searchUsers({String? query});

  Future<ApiResult<SingleUserResponse>> getUserDetails(String? uuid);

  Future<ApiResult<UsersPaginateResponse>> getDeliveryMen({int? page});

  Future<ApiResult<SingleUserResponse>> updateUserRole({
    String? uuid,
    UserRole? role,
  });

  Future<ApiResult<SingleUserResponse>> updateUserDetails({
    String? uuid,
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
    String? image,
    String? dob,
    String? gender,
  });

  Future<ApiResult<UsersPaginateResponse>> getClients({int? page});

  Future<ApiResult<WalletHistoryResponse>> getWalletHistory({String? uuid});
}
