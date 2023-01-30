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
import 'widgets/brands_actions.dart';
import 'widgets/w_brand_item.dart';
import 'widgets/w_delete_brand_dialog.dart';

class BrandsPage extends ConsumerStatefulWidget {
  const BrandsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<BrandsPage> createState() => _BrandsPageState();
}

class _BrandsPageState extends ConsumerState<BrandsPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(brandsProvider.notifier).updateBrands();
      },
    );
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          ref.read(brandsProvider.notifier).fetchBrands();
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
    final state = ref.watch(brandsProvider);
    final notifier = ref.read(brandsProvider.notifier);
    return AbsorbPointer(
      absorbing: state.isLoading,
      child: Scaffold(
        backgroundColor: AppColors.mainBackground,
        appBar: CustomAppbar(
          title: AppHelpers.getTranslation(TrKeys.brands),
          leading: SmallIconButton(
            icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
              color: AppColors.black,
            ),
            onPressed: context.popRoute,
          ),
          actions: (LocalStorage.instance.getLoginData()?.user?.role == 'admin')
              ? getBrandsActions(context)
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 30,
                      ),
                      itemCount: state.brands.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final brand = state.brands[index];
                        return WBrandItem(
                          brand: brand,
                          onTap: LocalStorage.instance
                                      .getLoginData()
                                      ?.user
                                      ?.role ==
                                  'admin'
                              ? () async {
                                  ref
                                      .read(editBrandProvider.notifier)
                                      .fetchBrandDetails(brand.id);
                                  final shouldUpdate = await context.pushRoute(
                                          EditBrandRoute(id: brand.id ?? 0))
                                      as bool?;
                                  if (shouldUpdate != null && shouldUpdate) {
                                    await notifier.updateBrands();
                                  }
                                }
                              : null,
                          onDeleteTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return WDeleteBrandDialog(id: brand.id ?? 0);
                              },
                            );
                          },
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
