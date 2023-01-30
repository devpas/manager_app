import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../../../../riverpod/providers/providers.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';

class ChooseDeliveriesModal extends ConsumerStatefulWidget {
  const ChooseDeliveriesModal({Key? key}) : super(key: key);

  @override
  ConsumerState<ChooseDeliveriesModal> createState() =>
      _ChooseDeliveriesModalState();
}

class _ChooseDeliveriesModalState extends ConsumerState<ChooseDeliveriesModal> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(addOrderProvider.notifier).fetchShopDeliveries(
          checkYourNetwork: () {
            AppHelpers.showCheckFlash(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
        ref.read(addOrderProvider.notifier).getCalculations(
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
    final state = ref.watch(addOrderProvider);
    final notifier = ref.read(addOrderProvider.notifier);
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
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.white,
                              ),
                              padding: REdgeInsets.all(15),
                              margin: REdgeInsets.only(
                                bottom: 20,
                                left: 20,
                                right: 20,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${deliveryInfo.shop?.translation?.title}',
                                    style: GoogleFonts.inter(
                                      color: AppColors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  12.verticalSpace,
                                  PopupMenuButton<int>(
                                    itemBuilder: (context) {
                                      final shopDeliveries =
                                          deliveryInfo.shopDeliveries ?? [];
                                      return shopDeliveries
                                          .map(
                                            (delivery) => PopupMenuItem<int>(
                                              value: delivery.id,
                                              child: Text(
                                                  '${delivery.translation?.title}'),
                                            ),
                                          )
                                          .toList();
                                    },
                                    onSelected: (int? id) => notifier
                                        .setDeliveryType(id, deliveryInfo),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    color: AppColors.white,
                                    elevation: 10,
                                    child: SelectFromButton(
                                      iconData: FlutterRemix.navigation_fill,
                                      title: deliveryInfo.selectedShopDelivery
                                              ?.translation?.title ??
                                          AppHelpers.getTranslation(
                                              TrKeys.selectDeliveryType),
                                    ),
                                  ),
                                  12.verticalSpace,
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxWidth: 450.r,
                                              ),
                                              child: CustomDatePickerModal(
                                                onDateSaved: (DateTime? date) =>
                                                    notifier.setDeliveryDate(
                                                        date, deliveryInfo),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: SelectFromButton(
                                      iconData: FlutterRemix.calendar_fill,
                                      title: deliveryInfo.deliveryDate ??
                                          AppHelpers.getTranslation(
                                              TrKeys.selectDeliveryDate),
                                    ),
                                  ),
                                  12.verticalSpace,
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxWidth: 450.r,
                                              ),
                                              child: TimePickerModal(
                                                openTime:
                                                    deliveryInfo.shop?.openTime,
                                                closeTime: deliveryInfo
                                                    .shop?.closeTime,
                                                onSaved: (DateTime? date) =>
                                                    notifier.setDeliveryTime(
                                                        date, deliveryInfo),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: SelectFromButton(
                                      iconData: FlutterRemix.time_fill,
                                      title: deliveryInfo.deliveryTime ??
                                          AppHelpers.getTranslation(
                                              TrKeys.selectDeliveryTime),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        40.verticalSpace,
                        Padding(
                          padding: REdgeInsets.symmetric(horizontal: 20),
                          child: ConfirmButton(
                            title: AppHelpers.getTranslation(TrKeys.save),
                            onTap: context.popRoute,
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
