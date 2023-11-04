import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../theme/theme.dart';
import 'select_able_warehouse_item.dart';

class SelectWarehouseModal extends ConsumerWidget {
  const SelectWarehouseModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productsPASProvider);
    final notifier = ref.read(productsPASProvider.notifier);
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
              "Chọn kho hàng",
              style: AppTypographies.styBlack22W500,
            ),
            24.verticalSpace,
            state.warehouse!.isEmpty
                ? Center(
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.thereIsNoPayment),
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
                    itemCount: state.warehouse!.length,
                    itemBuilder: (context, index) {
                      final warehouse = state.warehouse![index];
                      return SelectableWarehouseItem(
                        warehouse: warehouse,
                        onTap: () {
                          notifier.setWarehouseSelected(warehouse);
                          context.popRoute();
                        },
                        isSelected: state.warehouseSelected!["id"] == warehouse["id"],
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
