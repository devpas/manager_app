import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../models/models.dart';
import '../../../../riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'widgets/expandable_shop_order_item.dart';
import 'widgets/order_detail_item_widget.dart';

class OrderDetailsPage extends ConsumerStatefulWidget {
  final int? orderId;

  const OrderDetailsPage({Key? key, required this.orderId}) : super(key: key);

  @override
  ConsumerState<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends ConsumerState<OrderDetailsPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(orderDetailsProvider.notifier).fetchOrderDetails(
              orderId: widget.orderId,
              checkYourNetwork: () {
                AppHelpers.showCheckFlash(
                  context,
                  AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
                );
              },
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderDetailsProvider);
    return AbsorbPointer(
      absorbing: state.isLoading,
      child: Scaffold(
        backgroundColor: AppColors.shopsPageBack,
        appBar: CustomAppbar(
          title:
              '${AppHelpers.getTranslation(TrKeys.order)} — #${widget.orderId}',
          leading: SmallIconButton(
            icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
              color: AppColors.black,
            ),
            onPressed: context.popRoute,
          ),
        ),
        body: state.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.greenMain,
                  strokeWidth: 3.r,
                ),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      physics: const CustomBouncingScrollPhysics(),
                      child: Column(
                        children: [
                          40.verticalSpace,
                          OrderDetailItemWidget(
                            title: AppHelpers.getTranslation(TrKeys.client),
                            value:
                                '${state.orderDetails?.data?.user?.firstname} ${state.orderDetails?.data?.user?.lastname}',
                          ),
                          OrderDetailItemWidget(
                            title: AppHelpers.getTranslation(TrKeys.phone),
                            value: state.orderDetails?.data?.user?.phone,
                          ),
                          OrderDetailItemWidget(
                            title: AppHelpers.getTranslation(TrKeys.email),
                            value: state.orderDetails?.data?.user?.email,
                          ),
                          OrderDetailItemWidget(
                            title: AppHelpers.getTranslation(TrKeys.address),
                            value: state.orderDetails?.data?.details?[0]
                                .deliveryAddress?.address,
                          ),
                          OrderDetailItemWidget(
                            title: AppHelpers.getTranslation(TrKeys.createdAt),
                            value: state.orderDetails?.data?.createdAt,
                          ),
                          OrderDetailItemWidget(
                            title: AppHelpers.getTranslation(TrKeys.amount),
                            value: NumberFormat.currency(
                              symbol:
                                  state.orderDetails?.data?.currency?.symbol,
                            ).format(state.orderDetails?.data?.price ?? 0),
                          ),
                          20.verticalSpace,
                          Container(
                            padding: REdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 17,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppColors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppHelpers.getTranslation(
                                      TrKeys.paymentStatus),
                                  style: AppTypographies.styBlack14W500,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(34.r),
                                    color: AppColors.red.withOpacity(0.1),
                                  ),
                                  alignment: Alignment.center,
                                  padding: REdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 28,
                                  ),
                                  child: Text(
                                    '${state.orderDetails?.data?.details?[0].transaction?.status}',
                                    style: AppTypographies.styRed14W500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          10.verticalSpace,
                          Container(
                            padding: REdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 17,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppColors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppHelpers.getTranslation(
                                      TrKeys.paymentMethod),
                                  style: AppTypographies.styBlack14W500,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(34.r),
                                    color: AppColors.greenMain.withOpacity(0.1),
                                  ),
                                  alignment: Alignment.center,
                                  padding: REdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 28,
                                  ),
                                  child: Text(
                                    '${state.orderDetails?.data?.details?[0].transaction?.paymentSystem?.translation?.title}',
                                    style: AppTypographies.styGreen14W500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          20.verticalSpace,
                          ListView.builder(
                            itemCount: state.shopOrderDetails.length,
                            shrinkWrap: true,
                            physics: const CustomBouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final ShopOrderDetails orderDetails =
                                  state.shopOrderDetails[index];
                              return ExpandableShopOrderItem(
                                orderDetails: orderDetails,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlurLoadingWidget(isLoading: state.isUpdatingStatus),
                ],
              ),
      ),
    );
  }
}
