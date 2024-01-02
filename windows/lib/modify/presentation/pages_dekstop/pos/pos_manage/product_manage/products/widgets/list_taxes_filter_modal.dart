import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:g_manager_app/src/core/utils/app_helpers.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';
import 'search_category_modal_in_filter_products_pas.dart';

// ignore: must_be_immutable
class ListTaxesFilterModal extends ConsumerWidget {
  ListTaxesFilterModal({Key? key}) : super(key: key);

  List sortCondition = [
    [0, "Tên"],
    [1, "Giá"],
    [3, "Thứ tự"]
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateBase = ref.watch(baseProvider);
    final state = ref.watch(productsPASProvider);
    final notifier = ref.read(productsPASProvider.notifier);
    return Material(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 23,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stateBase.translate[stateBase.languageSelected]["barcode"],
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: -0.4,
                color: AppColors.black.withOpacity(0.3),
              ),
            ),
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {
                notifier.codeRef = value;
                print(notifier.codeRef);
              },
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: -0.4,
                color: AppColors.black,
              ),
              decoration: InputDecoration(
                hintStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  letterSpacing: -0.4,
                  color: AppColors.inputNameHint,
                ),
              ),
            ),
            20.verticalSpace,
            SelectWithSearchPosButton(
              iconData: FlutterRemix.arrow_down_s_line,
              label: stateBase.translate[stateBase.languageSelected]["category"],
              title: sortCondition.where((type) => type[0] == state.sortProductsId).first[1],
              onTap: () {
                notifier.keySearch = "";
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return Material(
                      color: AppColors.mainBackground,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 20,
                          left: 15,
                          right: 15,
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                physics: const CustomBouncingScrollPhysics(),
                                itemCount: sortCondition.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return SearchedItem(
                                    title: '${sortCondition[index][1]}',
                                    isSelected: false,
                                    onTap: () {
                                      notifier.setSortProductsSelected(sortCondition[index][0]);
                                      Future.delayed(Duration(milliseconds: 100), () {
                                        Navigator.pop(context);
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                            30.verticalSpace,
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            40.verticalSpace,
            CommonAccentButton(
              title: stateBase.translate[stateBase.languageSelected]["show_result"],
              onPressed: () {
                context.popRoute();
              },
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
