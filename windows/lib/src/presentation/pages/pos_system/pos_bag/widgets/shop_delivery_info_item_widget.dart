import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../models/models.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';

class ShopDeliveryInfoItemWidget extends StatelessWidget {
  final ShopDeliveryInfo deliveryInfo;
  final Function(int?) onShopDeliverySelected;
  final Function(DateTime?) onDeliveryDateSelected;
  final Function(DateTime?) onDeliveryTimeSelected;

  const ShopDeliveryInfoItemWidget({
    Key? key,
    required this.deliveryInfo,
    required this.onShopDeliverySelected,
    required this.onDeliveryDateSelected,
    required this.onDeliveryTimeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              CommonImage(
                imageUrl: deliveryInfo.shop?.logoImg,
                width: 40,
                height: 40,
              ),
            ],
          ),
          12.verticalSpace,
          PopupMenuButton<int>(
            itemBuilder: (context) {
              final shopDeliveries = deliveryInfo.shopDeliveries ?? [];
              return shopDeliveries
                  .map(
                    (delivery) => PopupMenuItem<int>(
                      value: delivery.id,
                      child: Text('${delivery.translation?.title}'),
                    ),
                  )
                  .toList();
            },
            onSelected: onShopDeliverySelected,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            color: AppColors.white,
            elevation: 10,
            child: SelectFromButton(
              iconData: FlutterRemix.navigation_fill,
              title: deliveryInfo.selectedShopDelivery?.translation?.title ??
                  AppHelpers.getTranslation(TrKeys.selectDeliveryType),
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
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 450.r,
                      ),
                      child: CustomDatePickerModal(
                        onDateSaved: onDeliveryDateSelected,
                      ),
                    ),
                  );
                },
              );
            },
            child: SelectFromButton(
              iconData: FlutterRemix.calendar_fill,
              title: deliveryInfo.deliveryDate ??
                  AppHelpers.getTranslation(TrKeys.selectDeliveryDate),
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
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 450.r,
                      ),
                      child: TimePickerModal(
                        openTime: deliveryInfo.shop?.openTime,
                        closeTime: deliveryInfo.shop?.closeTime,
                        onSaved: onDeliveryTimeSelected,
                      ),
                    ),
                  );
                },
              );
            },
            child: SelectFromButton(
              iconData: FlutterRemix.time_fill,
              title: deliveryInfo.deliveryTime ??
                  AppHelpers.getTranslation(TrKeys.selectDeliveryTime),
            ),
          ),
        ],
      ),
    );
  }
}
