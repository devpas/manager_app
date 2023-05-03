import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../models/models.dart';
import '../../../../riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'widgets/pos_shop_item_widget.dart';
import 'widgets/pos_total_amounts_widget.dart';
import 'widgets/search_user_modal_pos_bag.dart';
import 'widgets/select_address_modal_in_pos_bag.dart';
import 'widgets/select_currency_modal_in_pos_bag.dart';
import 'widgets/select_payment_modal_in_pos_bag.dart';

class PosBagPage extends ConsumerStatefulWidget {
  final PosSystemBagData bag;

  const PosBagPage({Key? key, required this.bag}) : super(key: key);

  @override
  ConsumerState<PosBagPage> createState() => _PosBagPageState();
}

class _PosBagPageState extends ConsumerState<PosBagPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(posBagProvider.notifier).setInitialPosBag(context, widget.bag);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(posBagProvider);
    final notifier = ref.read(posBagProvider.notifier);
    return AbsorbPointer(
      absorbing: state.isPaymentsLoading ||
          state.isCurrenciesLoading ||
          state.isUserDetailsLoading ||
          state.isShopsLoading,
      child: Scaffold(
        backgroundColor: AppColors.mainBackground,
        appBar: CustomAppbar(
          title:
              '${AppHelpers.getTranslation(TrKeys.bag)} - ${(widget.bag.index ?? 0) + 1}',
          leading: SmallIconButton(
            icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
              color: AppColors.black,
              size: 24.r,
            ),
            onPressed: context.popRoute,
          ),
        ),
        body: (state.isCurrenciesLoading || state.isPaymentsLoading)
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3.r,
                  color: AppColors.greenMain,
                ),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  SingleChildScrollView(
                    physics: const CustomBouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: AppColors.white,
                          padding: REdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              24.verticalSpace,
                              SelectWithAddButton(
                                label: AppHelpers.getTranslation(TrKeys.client),
                                title: state.posBagData?.selectedUser == null
                                    ? AppHelpers.getTranslation(
                                        TrKeys.selectUser)
                                    : '${state.posBagData?.selectedUser?.firstname} ${state.posBagData?.selectedUser?.lastname}',
                                onSelectTap: () {
                                  notifier.setUserQuery(context, '');
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        const SearchUserModalInPosBag(),
                                  );
                                },
                              ),
                              if (state.posBagData?.selectedUser != null)
                                Padding(
                                  padding: REdgeInsets.only(top: 30.0),
                                  child: SelectWithAddButton(
                                    label: AppHelpers.getTranslation(
                                        TrKeys.address),
                                    title: state.posBagData?.selectedAddress ==
                                            null
                                        ? AppHelpers.getTranslation(
                                            TrKeys.selectAddress)
                                        : '${state.posBagData?.selectedAddress?.address}',
                                    onSelectTap: () => showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          const SelectAddressModalInPosBag(),
                                    ),
                                  ),
                                ),
                              30.verticalSpace,
                              SelectWithAddButton(
                                label:
                                    AppHelpers.getTranslation(TrKeys.currency),
                                title: state.posBagData?.selectedCurrency ==
                                        null
                                    ? AppHelpers.getTranslation(
                                        TrKeys.selectCurrency)
                                    : '${state.posBagData?.selectedCurrency?.title} - (${state.posBagData?.selectedCurrency?.symbol})',
                                onSelectTap: () => showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      const SelectCurrencyModalInPosBag(),
                                ),
                              ),
                              30.verticalSpace,
                              SelectWithAddButton(
                                label:
                                    AppHelpers.getTranslation(TrKeys.payment),
                                title: state.posBagData?.selectedPayment == null
                                    ? AppHelpers.getTranslation(
                                        TrKeys.selectPayment)
                                    : '${state.posBagData?.selectedPayment?.translation?.title}',
                                onSelectTap: () => showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      const SelectPaymentModalInPosBag(),
                                ),
                              ),
                              18.verticalSpace,
                            ],
                          ),
                        ),
                        24.verticalSpace,
                        (state.posBagData?.posShops?.isEmpty ?? true)
                            ? Center(
                                child: Text(
                                  AppHelpers.getTranslation(
                                      TrKeys.noProductsSelected),
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                              )
                            : Padding(
                                padding:
                                    REdgeInsets.symmetric(horizontal: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListView(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      primary: false,
                                      children: [
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          primary: false,
                                          padding: REdgeInsets.symmetric(
                                              vertical: 12),
                                          itemCount: state
                                              .posBagData?.posShops?.length,
                                          itemBuilder: (context, index) {
                                            final posShop = state
                                                .posBagData?.posShops?[index];
                                            return PosShopItemWidget(
                                              posShop: posShop,
                                              onDeleteProduct: (product) {
                                                notifier.deleteProductFromBag(
                                                    context,
                                                    ref.read(posSystemProvider
                                                        .notifier),
                                                    product);
                                              },
                                              onDecreaseProduct: (product) {
                                                notifier.decreaseProductCount(
                                                    ref.read(posSystemProvider
                                                        .notifier),
                                                    product);
                                              },
                                              onIncreaseProduct: (product) {
                                                notifier.increaseProductCount(
                                                  ref.read(posSystemProvider
                                                      .notifier),
                                                  product,
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        const PosTotalAmountsWidget()
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                  BlurLoadingWidget(
                    isLoading:
                        state.isUserDetailsLoading || state.isShopsLoading,
                  ),
                ],
              ),
        bottomNavigationBar: Container(
          height: 110.r,
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
          padding: REdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.totalAmount),
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: AppColors.black,
                      letterSpacing: -0.3,
                    ),
                  ),
                  5.verticalSpace,
                  Text(
                    NumberFormat.currency(
                      symbol:
                          LocalStorage.instance.getSelectedCurrency()?.symbol,
                    ).format(
                      state.subtotal + state.productTax + state.shopTax,
                    ),
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              Material(
                borderRadius: BorderRadius.circular(68.r),
                color: AppColors.greenMain,
                child: InkWell(
                  borderRadius: BorderRadius.circular(68.r),
                  onTap: (state.posBagData?.bagProducts?.isEmpty ?? false)
                      ? null
                      : () => notifier.chooseDeliveries(context),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(68.r),
                    ),
                    padding: REdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 19,
                    ),
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.next),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        color: AppColors.white,
                        letterSpacing: 14 * 0.02,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
