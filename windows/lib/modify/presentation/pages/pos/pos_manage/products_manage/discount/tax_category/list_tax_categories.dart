import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/products/product_provider.dart';
import 'package:g_manager_app/src/core/routes/app_router.gr.dart';

import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';
import '../widgets/tax_category_action.dart';
import '../widgets/tax_category_item.dart';
import '../widgets/w_delete_tax_category_dialog.dart';

class ListTaxCategoriesPage extends ConsumerStatefulWidget {
  const ListTaxCategoriesPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ListTaxCategoriesPage> createState() => _ListTaxCategoriesPageState();
}

class _ListTaxCategoriesPageState extends ConsumerState<ListTaxCategoriesPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(productsPASProvider.notifier).getListTaxCategories();
      },
    );
    _scrollController = ScrollController();
    // _scrollController.addListener(
    //   () {
    //     if (_scrollController.position.maxScrollExtent ==
    //         _scrollController.position.pixels) {
    //       ref.read(categoriesPASProvider.notifier).fetchCategoriesAppscript();
    //     }
    //   },
    // );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productsPASProvider);
    // final notifier = ref.watch(productsPASProvider.notifier);
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        backgroundColor: AppColors.mainBackground,
        appBar: CustomAppbarPOS(
          actions: addTaxCategory(context),
          title: Text(
            "Danh mục chiếc khấu",
            style: AppTypographies.styBlack16W500,
            textAlign: TextAlign.center,
          ),
          leading: Builder(
            builder: (context) => SmallIconButton(
              icon: Icon(
                FlutterRemix.arrow_left_s_line,
                size: 24.r,
                color: AppColors.black,
              ),
              onPressed: context.popRoute,
            ),
          ),
        ),
        body: state.taxCategoryLoading!
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.greenMain,
                  strokeWidth: 3.r,
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const CustomBouncingScrollPhysics(),
                      padding: REdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 10,
                      ),
                      itemCount: state.taxCategories!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final taxCategory = state.taxCategories![index];
                        return TaxCategoryItem(
                          taxCategory: taxCategory,
                          onEditTap: () async {
                            context.pushRoute(
                              UpdateTaxCategoryRoute(taxCategory: taxCategory),
                            );
                          },
                          onDeleteTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return DeleteTaxCategoryDialog(
                                  alias: taxCategory["id"].toString(),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
