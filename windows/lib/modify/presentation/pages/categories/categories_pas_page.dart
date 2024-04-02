import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/categories/category_provider.dart';

import '../../../../src/core/routes/app_router.gr.dart';
import '../../../../src/core/utils/utils.dart';
import '../../../../modify/presentation/components/components.dart';
import '../../../../modify/presentation/theme/theme.dart';
import '../../../riverpob/providers/providers.dart';
import 'add/widgets/w_category_item.dart';
import 'widgets/w_delete_category_dialog.dart';
import 'widgets/categories_actions.dart';

class CategoriesPasPage extends ConsumerStatefulWidget {
  const CategoriesPasPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoriesPasPage> createState() => _CategoriesPasPageState();
}

class _CategoriesPasPageState extends ConsumerState<CategoriesPasPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(categoriesPASProvider.notifier).fetchCategories();
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
    final state = ref.watch(categoriesPASProvider);

    final notifierBase = ref.read(baseProvider.notifier);
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        backgroundColor: AppColors.mainBackground,
        appBar: CustomAppbarPOS(
          actions: addCategoriesActions(context),
          title: Text(
            "Danh mục",
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
        body: state.categories!.isEmpty
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
                        vertical: 30,
                        horizontal: 15,
                      ),
                      itemCount: state.categories!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final category = state.categories![index];
                        if (category.id != -1) {
                          return WCategoryItem(
                            userRole: LocalStorage.instance.getShareMode() ? notifierBase.getRoleCode().where((e) => e.contains("pos-")).first : "",
                            category: category,
                            onEditTap: () async {
                              context.pushRoute(
                                EditCategoryPasRoute(category: category),
                              );
                            },
                            onDeleteTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return WDeleteCategoryDialog(
                                    alias: category.id!,
                                  );
                                },
                              );
                            },
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
