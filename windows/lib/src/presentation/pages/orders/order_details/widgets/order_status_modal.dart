import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../models/models.dart';
import '../../../../../riverpod/providers/providers.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';

class OrderStatusModal extends ConsumerStatefulWidget {
  final ShopOrderDetails? orderDetails;

  const OrderStatusModal({Key? key, required this.orderDetails})
      : super(key: key);

  @override
  ConsumerState<OrderStatusModal> createState() => _OrderStatusModalState();
}

class _OrderStatusModalState extends ConsumerState<OrderStatusModal> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref
            .read(orderStatusProvider.notifier)
            .setOrderShopDetails(orderDetails: widget.orderDetails);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderStatusProvider);
    final notifier = ref.read(orderStatusProvider.notifier);
    return AbsorbPointer(
      absorbing: state.isLoading,
      child: Material(
        color: AppColors.white,
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 15.0, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppHelpers.getTranslation(TrKeys.changeOrderDetailStatus),
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.4,
                ),
              ),
              20.verticalSpace,
              OrderStatusButton(
                orderStatus: OrderStatus.newOrder,
                isSelected: state.activeOrderStatus == OrderStatus.newOrder,
              ),
              OrderStatusButton(
                orderStatus: OrderStatus.accepted,
                isSelected: state.activeOrderStatus == OrderStatus.accepted,
                onTap: state.initialOrderStatus == OrderStatus.newOrder
                    ? () => notifier.changeStatus(OrderStatus.accepted)
                    : null,
              ),
              OrderStatusButton(
                orderStatus: OrderStatus.ready,
                isSelected: state.activeOrderStatus == OrderStatus.ready,
                onTap: state.initialOrderStatus == OrderStatus.accepted
                    ? () => notifier.changeStatus(OrderStatus.ready)
                    : null,
              ),
              OrderStatusButton(
                orderStatus: OrderStatus.onAWay,
                isSelected: state.activeOrderStatus == OrderStatus.onAWay,
                onTap: state.initialOrderStatus == OrderStatus.ready
                    ? () => notifier.changeStatus(OrderStatus.onAWay)
                    : null,
              ),
              OrderStatusButton(
                orderStatus: OrderStatus.delivered,
                isSelected: state.activeOrderStatus == OrderStatus.delivered,
                onTap: state.initialOrderStatus == OrderStatus.onAWay
                    ? () => notifier.changeStatus(OrderStatus.delivered)
                    : null,
              ),
              OrderStatusButton(
                orderStatus: OrderStatus.canceled,
                isSelected: state.activeOrderStatus == OrderStatus.canceled,
                onTap: state.initialOrderStatus == OrderStatus.canceled
                    ? null
                    : () => notifier.changeStatus(OrderStatus.canceled),
                titleColor: AppColors.red,
              ),
              30.verticalSpace,
              ConfirmButton(
                title: AppHelpers.getTranslation(TrKeys.save),
                isLoading: state.isLoading,
                onTap: () => notifier.saveOrderStatus(
                  checkYourNetwork: () {
                    AppHelpers.showCheckFlash(
                      context,
                      AppHelpers.getTranslation(
                          TrKeys.checkYourNetworkConnection),
                    );
                  },
                  updateOrderDetails: () {
                    context.popRoute();
                    ref.read(orderDetailsProvider.notifier).updateOrderDetails(
                      checkYourNetwork: () {
                        AppHelpers.showCheckFlash(
                          context,
                          AppHelpers.getTranslation(
                              TrKeys.checkYourNetworkConnection),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
