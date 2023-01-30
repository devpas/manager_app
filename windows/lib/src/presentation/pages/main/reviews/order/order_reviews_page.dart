import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../riverpod/providers/providers.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';
import 'widgets/are_you_sure_modal_in_order_review.dart';
import 'widgets/order_review_item.dart';

class OrderReviewsPage extends ConsumerStatefulWidget {
  const OrderReviewsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderReviewsPage> createState() => _OrderReviewsPageState();
}

class _OrderReviewsPageState extends ConsumerState<OrderReviewsPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(orderReviewsProvider.notifier).fetchOrderReviews(
          checkYourNetwork: () {
            AppHelpers.showCheckFlash(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
      },
    );
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          ref.read(orderReviewsProvider.notifier).fetchOrderReviews(
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
    final state = ref.watch(orderReviewsProvider);
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: CustomAppbar(
        title: AppHelpers.getTranslation(TrKeys.orderReviews),
        leading: SmallIconButton(
          icon: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
            color: AppColors.black,
            size: 24.r,
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
          : state.reviews.isEmpty
              ? Center(
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.thereIsNoOrderReviews),
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : ListView(
                  physics: const CustomBouncingScrollPhysics(),
                  controller: _scrollController,
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: REdgeInsets.only(
                        top: 20,
                        left: 15,
                        right: 15,
                        bottom: state.isMoreLoading ? 0 : 50,
                      ),
                      shrinkWrap: true,
                      itemCount: state.reviews.length,
                      itemBuilder: (context, index) {
                        final review = state.reviews[index];
                        return OrderReviewItem(
                          review: review,
                          onDeleteTap: () => showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => AreYouSureModalInOrderReview(
                              reviewData: review,
                            ),
                          ),
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
                          50.verticalSpace,
                        ],
                      )
                  ],
                ),
    );
  }
}
