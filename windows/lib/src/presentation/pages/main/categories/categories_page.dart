import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../core/utils/utils.dart';
import '../../../../riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'widgets/categories_actions.dart';
import 'add/widgets/w_category_item.dart';
import 'widgets/w_delete_category_dialog.dart';

class CategoriesPage extends ConsumerStatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoriesPage> createState() => _BrandsPageState();
}

class _BrandsPageState extends ConsumerState<CategoriesPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(categoriesProvider.notifier).updateCategories();
      },
    );
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          ref.read(categoriesProvider.notifier).fetchCategories();
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
    final state = ref.watch(categoriesProvider);
    final notifier = ref.read(categoriesProvider.notifier);
    return AbsorbPointer(
      absorbing: state.isLoading,
      child: Scaffold(
        backgroundColor: AppColors.mainBackground,
        appBar: CustomAppbar(
          title: AppHelpers.getTranslation(TrKeys.categories),
          leading: SmallIconButton(
            icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
              color: AppColors.black,
            ),
            onPressed: context.popRoute,
          ),
          actions: (LocalStorage.instance.getLoginData()?.user?.role == 'admin')
              ? getCategoriesActions(context)
              : null,
        ),
        body: state.isLoading
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
                        horizontal: 15,
                        vertical: 30,
                      ),
                      itemCount: state.categories.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final category = state.categories[index];
                        return WCategoryItem(
                          category: category,
                          onEditTap: (LocalStorage.instance
                                      .getLoginData()
                                      ?.user
                                      ?.role ==
                                  'admin')
                              ? () async {
                                  ref
                                      .read(editCategoryProvider.notifier)
                                      .fetchCategoryDetails(
                                          category.uuid ?? '');
                                  final shouldUpdate = await context.pushRoute(
                                    EditCategoryRoute(
                                        alias: category.uuid ?? ''),
                                  ) as bool?;
                                  if (shouldUpdate != null && shouldUpdate) {
                                    await notifier.updateCategories();
                                  }
                                }
                              : null,
                          onDeleteTap: (LocalStorage.instance
                                      .getLoginData()
                                      ?.user
                                      ?.role ==
                                  'admin')
                              ? () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return WDeleteCategoryDialog(
                                        alias: category.uuid ?? '',
                                      );
                                    },
                                  );
                                }
                              : null,
                        );
                      },
                    ),
                  ),
                  if (state.isMoreLoading)
                    Center(
                      child: CircularProgressIndicator(
                        color: AppColors.greenMain,
                        strokeWidth: 2.r,
                      ),
                    )
                ],
              ),
      ),
    );
  }
}
