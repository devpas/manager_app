import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:g_manager_app/modify/riverpob/states/states.dart';
import 'package:g_manager_app/modify/models/models.dart';
import 'package:intl/intl.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/utils/utils.dart';
import '../../../../models/models.dart';
import '../../../../../src/riverpod/providers/providers.dart';
import '../../../../riverpob/notifiers/products/products_notifier.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import '../widgets/ticketline_item.dart';
import 'widgets/expandable_shop_order_item.dart';
import 'widgets/order_detail_item_widget.dart';

class OrderDetailsPasPage extends ConsumerStatefulWidget {
  final TicketData? order;

  const OrderDetailsPasPage({Key? key, required this.order}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  ConsumerState<OrderDetailsPasPage> createState() =>
      _OrderDetailsPasPageState(order: order);
}

class _OrderDetailsPasPageState extends ConsumerState<OrderDetailsPasPage> {
  final TicketData? order;

  _OrderDetailsPasPageState({required this.order});

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        // ref.read(orderDetailsProvider.notifier).fetchOrderDetails(
        //       orderId: widget.orderId,
        //       checkYourNetwork: () {
        //         AppHelpers.showCheckFlash(
        //           context,
        //           AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        //         );
        //       },
        //     );
      },
    );
  }

  ProductPasData getProductById(
      int productId, ProductsPasNotifier notifierProduct) {
    ProductPasData product = notifierProduct.listProductCache
        .where((e) => e.id == productId)
        .toList()
        .first;
    return product;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderDetailsProvider);
    final notifierProduct = ref.watch(productsPASProvider.notifier);
    return AbsorbPointer(
      absorbing: state.isLoading,
      child: Scaffold(
        backgroundColor: AppColors.shopsPageBack,
        appBar: CustomAppbarPOS(
          title: Text(
            "Đơn hàng số ${order!.ticketId}",
            style: AppTypographies.styBlack16W400,
          ),
          leading: Builder(
            builder: (context) => SmallIconButton(
              icon: Icon(
                FlutterRemix.arrow_left_line,
                size: 24.r,
                color: AppColors.black,
              ),
              onPressed: () {
                context.popRoute();
              },
            ),
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
                          const OrderDetailItemWidget(
                            title: "khách hàng",
                            value: 'Chưa có dữ liệu',
                          ),
                          const OrderDetailItemWidget(
                            title: "Nhân viên xuất phiếu",
                            value: 'Chưa có dữ liệu',
                          ),
                          OrderDetailItemWidget(
                            title: "Ngày xuất phiếu",
                            value: order!.datenew.toString(),
                          ),
                          OrderDetailItemWidget(
                            title: "Tổng tiền",
                            value: order!.payments![0].total.toString(),
                          ),
                          OrderDetailItemWidget(
                            title: "Phương thức thanh toán",
                            value: order!.ticketType == 0
                                ? "Tiền mặt"
                                : order!.ticketType == 1
                                    ? "Nợ"
                                    : "Trả nợ",
                          ),
                          20.verticalSpace,
                          OrderDetailItemWidget(
                            title: AppHelpers.getTranslation(TrKeys.createdAt),
                            value: state.orderDetails?.data?.createdAt,
                          ),
                          20.verticalSpace,
                          ListView.builder(
                            itemCount: order!.ticketlines!.length,
                            shrinkWrap: true,
                            physics: const CustomBouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final TicketLineData ticketline =
                                  order!.ticketlines![index];
                              final ProductPasData product = getProductById(
                                  ticketline.productId!, notifierProduct);
                              return TicketlineItem(
                                product: product,
                                ticketline: ticketline,
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
