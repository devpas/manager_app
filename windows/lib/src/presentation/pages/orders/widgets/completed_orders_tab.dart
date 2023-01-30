import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../core/utils/utils.dart';
import '../../../../riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class CompletedOrdersTab extends ConsumerStatefulWidget {
  const CompletedOrdersTab({Key? key}) : super(key: key);

  @override
  ConsumerState<CompletedOrdersTab> createState() => _CompletedOrdersTabState();
}

class _CompletedOrdersTabState extends ConsumerState<CompletedOrdersTab> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        final orderState = ref.watch(ordersProvider);
        ref.read(completedOrdersProvider.notifier).updateOrders(
              userId: orderState.selectedUser?.id,
            );
      },
    );
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          ref.read(completedOrdersProvider.notifier).fetchOrders();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(completedOrdersProvider);
    return state.isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.greenMain,
              strokeWidth: 3.r,
            ),
          )
        : state.orders.isEmpty
            ? Center(
                child: Text(
                  AppHelpers.getTranslation(TrKeys.thereIsNoCompletedOrders),
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : ListView(
                controller: _scrollController,
                physics: const CustomBouncingScrollPhysics(),
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: REdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 14,
                      bottom: state.isMoreLoading ? 0 : 97,
                    ),
                    itemCount: state.orders.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final order = state.orders[index];
                      return OrderItem(
                        order: order,
                        onTap: () => context
                            .pushRoute(OrderDetailsRoute(orderId: order.id)),
                      );
                    },
                  ),
                  if (state.isMoreLoading)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: CircularProgressIndicator(
                            color: AppColors.greenMain,
                            strokeWidth: 2.r,
                          ),
                        ),
                        127.verticalSpace,
                      ],
                    )
                ],
              );
  }
}
