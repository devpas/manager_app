import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/categories/category_provider.dart';
import 'package:g_manager_app/modify/riverpob/providers/products/product_provider.dart';

import '../../../../../../../src/core/routes/app_router.gr.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';
import 'widgets/stock_item.dart';
import 'widgets/w_delete_warehouse_dialog.dart';
import 'widgets/warehouse_action.dart';

class ListStocksPage extends ConsumerStatefulWidget {
  const ListStocksPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ListStocksPage> createState() => _ListStocksPageState();
}

class _ListStocksPageState extends ConsumerState<ListStocksPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(productsPASProvider.notifier).getListWarehouses();
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
    final notifier = ref.watch(productsPASProvider.notifier);
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        backgroundColor: AppColors.mainBackground,
        appBar: CustomAppbarPOS(
          actions: addWarehouse(context),
          title: Text(
            "Kho bãi",
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
        body: state.warehouseLoading!
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
                      itemCount: state.warehouse!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final warehouse = state.warehouse![index];
                        return StockItem(
                          warehouse: warehouse,
                          onEditTap: () async {
                            context.pushRoute(
                              UpdateWarehouseRoute(warehouse: warehouse),
                            );
                          },
                          onDeleteTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return DeleteWarehouseDialog(
                                  alias: warehouse["id"],
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
