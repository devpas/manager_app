import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../core/utils/utils.dart';
import '../../../riverpod/providers/providers.dart';
import '../../components/components.dart';
import '../../theme/theme.dart';
import 'widgets/pos_sys_product_item.dart';
import 'widgets/product/add_pos_product_modal.dart';

class PosSystemPage extends ConsumerStatefulWidget {
  const PosSystemPage({Key? key}) : super(key: key);

  @override
  ConsumerState<PosSystemPage> createState() => _PosSystemPageState();
}

class _PosSystemPageState extends ConsumerState<PosSystemPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(posSystemProvider.notifier).fetchProducts(
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
          ref.read(posSystemProvider.notifier).fetchProducts();
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
    final state = ref.watch(posSystemProvider);
    final notifier = ref.read(posSystemProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SearchTextField(
                hintText: AppHelpers.getTranslation(TrKeys.searchProducts),
                onChanged: (value) =>
                    notifier.setProductQuery(context, value.trim()),
              ),
              Expanded(
                child: state.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3.r,
                          color: AppColors.greenMain,
                        ),
                      )
                    : state.products.isEmpty
                        ? Center(
                            child: Text(
                              AppHelpers.getTranslation(
                                  TrKeys.thereIsNoProducts),
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                                fontSize: 16.sp,
                                letterSpacing: -0.4,
                              ),
                            ),
                          )
                        : ListView(
                            physics: const CustomBouncingScrollPhysics(),
                            controller: _scrollController,
                            children: [
                              GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                primary: false,
                                itemCount: state.products.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 168 / 190,
                                  mainAxisSpacing: 9.r,
                                  crossAxisSpacing: 9.r,
                                  crossAxisCount: 2,
                                ),
                                padding: REdgeInsets.only(
                                  top: 24,
                                  left: 15,
                                  right: 15,
                                  bottom: state.isMoreLoading ? 0 : 97,
                                ),
                                itemBuilder: (context, index) {
                                  final product = state.products[index];
                                  return PosSysProductItem(
                                    product: product,
                                    onTap: () => showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          AddPosProductModal(product: product),
                                    ),
                                  );
                                },
                              ),
                              if (state.isMoreLoading)
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    9.verticalSpace,
                                    Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.greenMain,
                                        strokeWidth: 2.r,
                                      ),
                                    ),
                                    97.verticalSpace,
                                  ],
                                )
                            ],
                          ),
              )
            ],
          ),
          Positioned(
            bottom: 100,
            right: 15,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: state.bags
                      .map(
                        (bag) => PosBagButton(
                          isSelected: bag.index == state.activeBagIndex,
                          productsCount: bag.bagProducts?.length ?? 0,
                          onPressed: () {
                            if (bag.index == state.activeBagIndex) {
                              context.pushRoute(PosBagRoute(bag: bag));
                            } else {
                              notifier.makeSelectedBag(bag.index);
                            }
                          },
                        ),
                      )
                      .toList(),
                ),
                SizedBox(
                  width: 40.r,
                  height: 40.r,
                  child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: AppColors.greenMain,
                    onPressed:
                        state.bags.length > 3 ? null : notifier.addNewBag,
                    child: Icon(
                      FlutterRemix.add_line,
                      size: 20.r,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
