import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class BrandsRepository {
  Future<ApiResult<BrandsResponse>> getBrandsPaginate(int page);

  Future<ApiResult<SingleBrandResponse>> createBrand(
    String title,
    int? status,
    String? image,
  );

  Future<ApiResult<SingleBrandResponse>> deleteBrand(int brandId);

  Future<ApiResult<SingleBrandResponse>> getBrand(int? brandId);

  Future<ApiResult<SingleBrandResponse>> updateBrand({
    required int brandId,
    required String title,
    bool? status,
    String? image,
  });

  Future<ApiResult<BrandSearchResponse>> searchBrands(String? query);
}
