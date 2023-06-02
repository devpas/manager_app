import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../src/core/constants/constants.dart';
import '../../../../../../src/core/routes/app_router.gr.dart';
import '../../../../../../src/core/utils/utils.dart';
import '../../../../../../src/riverpod/providers/providers.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';

class BaseListEmployee extends ConsumerStatefulWidget {
  const BaseListEmployee({Key? key}) : super(key: key);

  @override
  ConsumerState<BaseListEmployee> createState() => _BaseListEmployeeState();
}

class _BaseListEmployeeState extends ConsumerState<BaseListEmployee> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(editUserProvider.notifier).updateOrders(context);
      },
    );
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          ref.read(editUserProvider.notifier).fetchUserOrders(
            checkYourNetwork: () {
              AppHelpers.showCheckFlash(
                context,
                AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
              );
            },
          );
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
    final state = ref.watch(editUserProvider);
    return state.isLoadingOrders
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.greenMain,
              strokeWidth: 3.r,
            ),
          )
        : state.orders.isEmpty
            ? Center(
                child: Text(
                  AppHelpers.getTranslation(TrKeys.thereIsNoOrdersForThisUser),
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.4,
                  ),
                ),
              )
            : Scaffold(
                floatingActionButton: FloatingActionButton(
                  backgroundColor: AppColors.greenMain,
                  onPressed: () {
                    context.pushRoute(const AddEmployeeRoute());
                  },
                  child: Icon(
                    FlutterRemix.add_line,
                    size: 20.r,
                    color: AppColors.white,
                  ),
                ),
                body: ListView(
                  physics: const CustomBouncingScrollPhysics(),
                  controller: _scrollController,
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: REdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 14,
                        bottom: state.isMoreLoadingOrders ? 0 : 20,
                      ),
                      itemCount: state.orders.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final order = state.orders[index];
                        return OrderItem(
                          background: AppColors.mainBackground,
                          order: order,
                          onTap: () => context
                              .pushRoute(OrderDetailsRoute(orderId: order.id)),
                        );
                      },
                    ),
                    if (state.isMoreLoadingOrders)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: CircularProgressIndicator(
                              color: AppColors.greenMain,
                              strokeWidth: 2.r,
                            ),
                          ),
                          20.verticalSpace,
                        ],
                      ),
                  ],
                ),
              );
  }
}
