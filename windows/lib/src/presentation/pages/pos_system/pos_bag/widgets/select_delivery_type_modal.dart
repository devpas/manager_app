import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../models/models.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';

class SelectDeliveryTypeModal extends StatelessWidget {
  final List<ShopDelivery> shopDeliveries;
  final Function(int?) onSelected;
  final ShopDelivery? selectedDelivery;

  const SelectDeliveryTypeModal({
    Key? key,
    required this.shopDeliveries,
    required this.onSelected,
    required this.selectedDelivery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            24.verticalSpace,
            Text(
              AppHelpers.getTranslation(TrKeys.selectCurrency),
              style: AppTypographies.styBlack22W500,
            ),
            24.verticalSpace,
            shopDeliveries.isEmpty
                ? Center(
                    child: Text(
                      AppHelpers.getTranslation(
                          TrKeys.thereIsNoDeliveryTypesInThisShop),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        letterSpacing: -0.4,
                        color: AppColors.black,
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const CustomBouncingScrollPhysics(),
                    itemCount: shopDeliveries.length,
                    itemBuilder: (context, index) {
                      final shopDelivery = shopDeliveries[index];
                      return SelectableDeliveryItem(
                        delivery: shopDelivery,
                        onTap: (id) {
                          onSelected(id);
                          context.popRoute();
                        },
                        isSelected: selectedDelivery?.id == shopDelivery.id,
                      );
                    },
                  ),
            50.verticalSpace,
          ],
        ),
      ),
    );
  }
}
