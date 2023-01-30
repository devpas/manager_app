import '../core/constants/constants.dart';
import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class OrdersRepository {
  Future<ApiResult<OrderPaginateResponse>> getOpenOrders({
    int? page,
    int? userId,
  });

  Future<ApiResult<OrderPaginateResponse>> getCompletedOrders({
    int? page,
    int? userId,
  });

  Future<ApiResult<OrderPaginateResponse>> getCanceledOrders({
    int? page,
    int? userId,
  });

  Future<ApiResult<CreateOrderResponse>> createOrder(OrderBodyData orderBody);

  Future<ApiResult<OrderDetailsResponse>> getOrderDetails(int? orderId);

  Future<ApiResult<OrderStatusResponse>> updateOrderStatus(
    int? orderDetailsId,
    OrderStatus status,
  );

  Future<ApiResult<OrderReviewsResponse>> getOrderReviews({int? page});

  Future<ApiResult<void>> deleteOrderReview(int? id);

  Future<ApiResult<OrderPaginateResponse>> getUserOrders({
    int? page,
    int? userId,
  });
}
