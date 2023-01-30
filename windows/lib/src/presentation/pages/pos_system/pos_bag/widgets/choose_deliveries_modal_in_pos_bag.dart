import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../riverpod/providers/providers.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';
import 'shop_delivery_info_item_widget.dart';

class ChooseDeliveriesModalInPosBag extends ConsumerStatefulWidget {
  const ChooseDeliveriesModalInPosBag({Key? key}) : super(key: key);

  @override
  ConsumerState<ChooseDeliveriesModalInPosBag> createState() =>
      _ChooseDeliveriesModalInPosBagState();
}

class _ChooseDeliveriesModalInPosBagState
    extends ConsumerState<ChooseDeliveriesModalInPosBag> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(posBagProvider.notifier).fetchShopDeliveries(
          checkYourNetwork: () {
            AppHelpers.showCheckFlash(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
        ref.read(posBagProvider.notifier).getCalculations(
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
    final state = ref.watch(posBagProvider);
    final notifier = ref.read(posBagProvider.notifier);
    return Material(
      color: AppColors.mainBackground,
      child: AbsorbPointer(
        absorbing: state.isCreatingOrder ||
            state.isCalculationsLoading ||
            state.isDeliveriesLoading,
        child: state.isDeliveriesLoading || state.isCalculationsLoading
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4.r,
                  color: AppColors.greenMain,
                ),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  SingleChildScrollView(
                    physics: const CustomBouncingScrollPhysics(),
                    child: Column(
                      children: [
                        50.verticalSpace,
                        Text(
                          AppHelpers.getTranslation(TrKeys.chooseDeliveries),
                          style: GoogleFonts.inter(
                            color: AppColors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.4,
                          ),
                        ),
                        20.verticalSpace,
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.zero,
                          itemCount: state.shopsDeliverInfo.length,
                          itemBuilder: (context, index) {
                            final deliveryInfo = state.shopsDeliverInfo[index];
                            return ShopDeliveryInfoItemWidget(
                              deliveryInfo: deliveryInfo,
                              onShopDeliverySelected: (id) =>
                                  notifier.setDeliveryType(id, deliveryInfo),
                              onDeliveryDateSelected: (date) =>
                                  notifier.setDeliveryDate(date, deliveryInfo),
                              onDeliveryTimeSelected: (time) =>
                                  notifier.setDeliveryTime(time, deliveryInfo),
                            );
                          },
                        ),
                        40.verticalSpace,
                        Padding(
                          padding: REdgeInsets.symmetric(horizontal: 20),
                          child: ConfirmButton(
                            title: AppHelpers.getTranslation(TrKeys.save),
                            onTap: () => notifier.makeAnOrder(
                              checkYourNetwork: () {
                                AppHelpers.showCheckFlash(
                                  context,
                                  AppHelpers.getTranslation(
                                      TrKeys.checkYourNetworkConnection),
                                );
                              },
                              goToOrders: () {
                                context.router.popUntilRoot();
                                ref
                                    .read(ordersProvider.notifier)
                                    .updateOpenOrders(
                                      openOrdersNotifier:
                                          ref.read(openOrdersProvider.notifier),
                                    );
                                ref
                                    .read(bottomBarProvider.notifier)
                                    .setActiveIndex(0);
                                ref
                                    .read(posSystemProvider.notifier)
                                    .removeBag(state.posBagData);
                              },
                            ),
                          ),
                        ),
                        40.verticalSpace,
                      ],
                    ),
                  ),
                  BlurLoadingWidget(isLoading: state.isCreatingOrder),
                ],
              ),
      ),
    );
  }
}
