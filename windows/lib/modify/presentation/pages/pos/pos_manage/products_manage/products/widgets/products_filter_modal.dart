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
              'Lọc sản phẩm',
              style: AppTypographies.styBlack22W500,
            ),
            20.verticalSpace,
            Text(
              AppHelpers.getTranslation("Mã vạch"),
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
              AppHelpers.getTranslation("Tên sản phẩm"),
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
              AppHelpers.getTranslation("Giá mua"),
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
              AppHelpers.getTranslation("Giá bán"),
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
              title:
                  "${stateCategory.categorySelected != null ? stateCategory.categorySelected!.name : 'Chọn danh mục'}",
            ),
            20.verticalSpace,
            SelectWithSearchPosButton(
              iconData: FlutterRemix.search_line,
              label: 'Sản phẩm',
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
                if (ProductNameSelected(state.productSelected!) !=
                    "Tìm sản phẩm") {
                  notifierPos.addTicketline(
                      state.productSelected!, statePos.selectTicket);
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