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
import 'widgets/w_delete_shop_dialog.dart';
import 'widgets/w_shops_item.dart';

class ShopsPage extends ConsumerStatefulWidget {
  const ShopsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ShopsPage> createState() => _ShopsPageState();
}

class _ShopsPageState extends ConsumerState<ShopsPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(shopsProvider.notifier).updateShops();
      },
    );
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          ref.read(shopsProvider.notifier).fetchShops();
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
    final shopsState = ref.watch(shopsProvider);
    final notifier = ref.read(shopsProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.shopsPageBack,
      appBar: CustomAppbar(
        title: AppHelpers.getTranslation(TrKeys.shops),
        leading: SmallIconButton(
          icon: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
            color: AppColors.black,
          ),
          onPressed: context.popRoute,
        ),
      ),
      body: shopsState.isLoading
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
                    itemCount: shopsState.shops.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final shop = shopsState.shops[index];
                      return WShopsItem(
                        shop: shop,
                        onTap: () async {
                          final shouldUpdate = await context.pushRoute(
                              ShopEditRoute(uuid: shop.uuid ?? '')) as bool?;
                          if (shouldUpdate != null && shouldUpdate) {
                            await notifier.updateShops();
                          }
                        },
                        onDeleteTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return WDeleteShopDialog(uuid: shop.uuid ?? '');
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                if (shopsState.isMoreLoading)
                  Center(
                    child: CircularProgressIndicator(
                      color: AppColors.greenMain,
                      strokeWidth: 2.r,
                    ),
                  )
              ],
            ),
    );
  }
}
