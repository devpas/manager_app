import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/data/product_data.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:g_manager_app/src/core/utils/app_helpers.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../orders/add_modify/widgets/order_detail/products/search_product_modal_in_order_detail_info_pas.dart';
import 'search_category_modal_in_filter_products_pas.dart';

class ProductsFilterModal extends ConsumerWidget {
  ProductsFilterModal({Key? key}) : super(key: key);

  String ProductNameSelected(ProductPasData product) {
    String title = "Tìm sản phẩm";
    if (product.id != 0) {
      title = product.name!;
    }
    return title;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateBase = ref.watch(baseProvider);
    final state = ref.watch(productsPASProvider);
    final notifier = ref.read(productsPASProvider.notifier);
    final stateCategory = ref.watch(categoriesPASProvider);
    final notifierCategory = ref.read(categoriesPASProvider.notifier);
    final statePos = ref.watch(posSystemPASProvider);
    final notifierPos = ref.read(posSystemPASProvider.notifier);
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
              stateBase.translate[stateBase.languageSelected]["filter_product"],
              style: AppTypographies.styBlack22W500,
            ),
            20.verticalSpace,
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
            Text(
              stateBase.translate[stateBase.languageSelected]["title_product_name"],
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: -0.4,
                color: AppColors.black.withOpacity(0.3),
              ),
            ),
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (input) {
                notifier.productName = input;
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
            Text(
              stateBase.translate[stateBase.languageSelected]["price_buy"],
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: -0.4,
                color: AppColors.black.withOpacity(0.3),
              ),
            ),
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (input) {
                notifier.priceBuy = double.parse(input);
              },
              keyboardType: TextInputType.number,
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
            Text(
              stateBase.translate[stateBase.languageSelected]["price_sell"],
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: -0.4,
                color: AppColors.black.withOpacity(0.3),
              ),
            ),
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (input) {
                notifier.priceSell = double.parse(input);
              },
              keyboardType: TextInputType.number,
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
              label: 'Danh mục',
              onTap: () {
                notifier.keySearch = "";
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return const SearchCategoryModalInFilterProductsPAS();
                  },
                );
              },
              title: "${stateCategory.categorySelected != null ? stateCategory.categorySelected!.name : stateBase.translate[stateBase.languageSelected]["select_category"]}",
            ),
            20.verticalSpace,
            SelectWithSearchPosButton(
              iconData: FlutterRemix.search_line,
              label: stateBase.translate[stateBase.languageSelected]["product"],
              onTap: () {
                notifier.keySearch = "";
                // notifier.filterProduct(
                //     stateCategory.categorySelected!, state.products!, "");
                Future.delayed(const Duration(milliseconds: 100), () {
                  notifier.searchProducts(stateCategory.categorySelected!.id!);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return const SearchProductModalInOrderDetailInfoPAS();
                    },
                  );
                });
              },
              title: ProductNameSelected(state.productSelected!),
            ),
            40.verticalSpace,
            CommonAccentButton(
              title: 'Show result',
              onPressed: () {
                if (ProductNameSelected(state.productSelected!) != "Tìm sản phẩm") {
                  notifierPos.addTicketline(state.productSelected!, statePos.selectTicket!, 0);
                }
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
