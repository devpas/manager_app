import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class ProductsRepository {
  Future<ApiResult<ProductsResponse>> getProductsPaginate({
    String? query,
    int? shopId,
    int? categoryId,
    int? brandId,
    int? page,
  });

  Future<ApiResult<DemoResponse>> createProduct({
    required String tax,
    required String minQuantity,
    required String maxQuantity,
    required int active,
    int? shopId,
    int? categoryId,
    int? brandId,
    required String title,
    required String description,
    String? image,
  });

  Future<ApiResult<DemoResponse>> deleteProduct(String uuid);

  Future<ApiResult<SingleProductResponse>> getProduct(String? uuid);

  Future<ApiResult<ProductsResponse>> searchProducts({
    String? query,
    int? shopId,
    int? categoryId,
    int? brandId,
  });

  Future<ApiResult<DemoResponse>> updateProduct({
    String? uuid,
    required String tax,
    required String minQuantity,
    required String maxQuantity,
    required int active,
    int? shopId,
    int? categoryId,
    int? brandId,
    required String title,
    required String description,
    String? image,
  });

  Future<ApiResult<ProductCalculateResponse>> getAllCalculations(
    List<OrderCartProductData> orderProducts,
  );

  Future<ApiResult<ProductCalculateResponse>> getAllCalculationsInPos(
    List<PosSystemBagProductData> posProducts,
  );

  Future<ApiResult<ProductReviewsResponse>> getProductReviews({int? page});

  Future<ApiResult<void>> deleteProductReview(int? id);
}
