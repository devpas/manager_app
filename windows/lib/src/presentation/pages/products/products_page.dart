import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../core/utils/utils.dart';
import '../../../riverpod/providers/providers.dart';
import '../../components/components.dart';
import '../../theme/theme.dart';
import 'widgets/products_filter_modal.dart';
import 'widgets/products_product_item.dart';
import 'widgets/w_delete_product_dialog.dart';

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(productsProvider.notifier).updateProducts();
      },
    );
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          ref.read(productsProvider.notifier).fetchProducts();
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
    final state = ref.watch(productsProvider);
    final notifier = ref.read(productsProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SearchTextField(
            textEditingController: state.searchController,
            onChanged: notifier.setQuery,
            hintText: AppHelpers.getTranslation(TrKeys.searchProducts),
            suffixIcon: SmallIconButton(
              onPressed: () => showCupertinoModalBottomSheet(
                context: context,
                builder: (context) => const ProductsFilterModal(),
              ),
              icon: Icon(
                FlutterRemix.sound_module_line,
                size: 24.r,
                color: AppColors.black,
              ),
            ),
          ),
          Expanded(
            child: state.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.greenMain,
                      strokeWidth: 3.r,
                    ),
                  )
                : state.products.isEmpty
                    ? Center(
                        child: Text(
                          AppHelpers.getTranslation(TrKeys.thereIsNoProducts),
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
                              bottom: state.isMoreLoading ? 0 : 97,
                            ),
                            shrinkWrap: true,
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              final product = state.products[index];
                              return ProductsProductItem(
                                product: product,
                                onTap: () async {
                                  final shouldUpdate = await context.pushRoute(
                                    EditProductRoute(
                                      uuid: product.uuid,
                                      from: OpenEditProductFrom.products,
                                    ),
                                  ) as bool?;
                                  if (shouldUpdate != null && shouldUpdate) {
                                    await notifier.updateProducts();
                                  }
                                },
                                onDeleteTap: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return WDeleteProductDialog(
                                        uuid: product.uuid ?? '',
                                      );
                                    },
                                  );
                                },
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
                                127.verticalSpace,
                              ],
                            )
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
