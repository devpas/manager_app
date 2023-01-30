import '../core/constants/constants.dart';
import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class ShopsRepository {
  Future<ApiResult<ShopsPaginateResponse>> getShopsPaginate(int page);

  Future<ApiResult<SingleShopResponse>> getSingleShop(String? uuid);

  Future<ApiResult<DemoResponse>> changeStatus(
    String? uuid,
    ShopStatus status,
  );

  Future<ApiResult<SingleShopResponse>> deleteShop(String uuid);

  Future<ApiResult<DemoResponse>> updateShop({
    required String? uuid,
    required String title,
    required ShopStatus status,
    required bool visibility,
    required String openTime,
    required String closeTime,
    required String userId,
    required String phone,
    required String description,
    required String minAmount,
    required String tax,
    required String percentage,
    required String address,
    required String deliveryRange,
    required String location,
    String? logoImg,
    String? backImg,
  });

  Future<ApiResult<ShopsPaginateResponse>> searchShops(String? query);

  Future<ApiResult<ShopsPaginateResponse>> getShopsByIds(
    List<int> shopIds,
  );

  Future<ApiResult<ShopDeliveriesResponse>> getOnlyDeliveries();
}
