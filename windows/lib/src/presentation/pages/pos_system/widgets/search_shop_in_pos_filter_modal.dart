import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class SearchShopInPosFilterModal extends ConsumerStatefulWidget {
  const SearchShopInPosFilterModal({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchShopInPosFilterModal> createState() =>
      _SearchShopModalState();
}

class _SearchShopModalState extends ConsumerState<SearchShopInPosFilterModal> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(posSystemProvider.notifier).fetchShops(
              query: '',
              checkYourNetwork: () {
                AppHelpers.showCheckFlash(
                  context,
                  AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
                );
              },
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(posSystemProvider);
    final notifier = ref.read(posSystemProvider.notifier);
    return Material(
      color: AppColors.mainBackground,
      child: Container(
        padding: REdgeInsets.only(
          top: 20,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchTextField(
              onChanged: (value) =>
                  notifier.setShopQuery(context, value.trim()),
              hintText: AppHelpers.getTranslation(TrKeys.searchShop),
            ),
            10.verticalSpace,
            SearchedItem(
              title: AppHelpers.getTranslation(TrKeys.allShops),
              isSelected: state.selectedShop == null,
              onTap: () {
                notifier.setSelectedShop(null);
                context.popRoute();
              },
            ),
            state.isShopsLoading
                ? Padding(
                    padding: REdgeInsets.symmetric(vertical: 20.0),
                    child: CircularProgressIndicator(
                      strokeWidth: 3.r,
                      color: AppColors.greenMain,
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      padding: REdgeInsets.symmetric(vertical: 10),
                      physics: const CustomBouncingScrollPhysics(),
                      itemCount: state.shops.length,
                      shrinkWrap: true,
                      controller: ModalScrollController.of(context),
                      itemBuilder: (context, index) {
                        final shop = state.shops[index];
                        return SearchedItem(
                          title: '${shop.translation?.title}',
                          isSelected: shop.id == state.selectedShop?.id,
                          onTap: () {
                            notifier.setSelectedShop(shop);
                            context.popRoute();
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
