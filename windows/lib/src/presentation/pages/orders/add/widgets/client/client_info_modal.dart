import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../../../../riverpod/providers/providers.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';
import 'search_user_modal_in_client_info.dart';
import 'select_address_modal.dart';
import 'select_currency_modal.dart';
import 'select_payment_modal.dart';

class ClientInfoModal extends ConsumerStatefulWidget {
  const ClientInfoModal({Key? key}) : super(key: key);

  @override
  ConsumerState<ClientInfoModal> createState() => _ClientInfoModalState();
}

class _ClientInfoModalState extends ConsumerState<ClientInfoModal> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(addOrderProvider.notifier).fetchCurrencies(
          checkYourNetwork: () {
            AppHelpers.showCheckFlash(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
        ref.read(addOrderProvider.notifier).fetchPayments(
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
    final state = ref.watch(addOrderProvider);
    final notifier = ref.read(addOrderProvider.notifier);
    return Material(
      color: AppColors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                24.verticalSpace,
                Text(
                  AppHelpers.getTranslation(TrKeys.clientInfo),
                  style: AppTypographies.styBlack22W500,
                ),
                59.verticalSpace,
                SelectWithAddButton(
                  label: AppHelpers.getTranslation(TrKeys.client),
                  title: state.selectedUser == null
                      ? AppHelpers.getTranslation(TrKeys.selectUser)
                      : '${state.selectedUser?.firstname} ${state.selectedUser?.lastname}',
                  onSelectTap: () {
                    notifier.setUserQuery(context, '');
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const SearchUserModalInClientInfo();
                      },
                    );
                  },
                ),
                if (state.selectedUser != null)
                  Padding(
                    padding: REdgeInsets.only(top: 30.0),
                    child: SelectWithAddButton(
                      label: AppHelpers.getTranslation(TrKeys.address),
                      title: state.selectedAddress == null
                          ? AppHelpers.getTranslation(TrKeys.selectAddress)
                          : '${state.selectedAddress?.address}',
                      onSelectTap: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => const SelectAddressModal(),
                      ),
                    ),
                  ),
                30.verticalSpace,
                SelectWithAddButton(
                  label: AppHelpers.getTranslation(TrKeys.currency),
                  title: state.selectedCurrency == null
                      ? AppHelpers.getTranslation(TrKeys.selectCurrency)
                      : '${state.selectedCurrency?.title} - (${state.selectedCurrency?.symbol})',
                  onSelectTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const SelectCurrencyModal(),
                    );
                  },
                ),
                30.verticalSpace,
                SelectWithAddButton(
                  label: AppHelpers.getTranslation(TrKeys.payment),
                  title: state.selectedPayment == null
                      ? AppHelpers.getTranslation(TrKeys.selectPayment)
                      : '${state.selectedPayment?.translation?.title}',
                  onSelectTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const SelectPaymentModal(),
                    );
                  },
                ),
                93.verticalSpace,
                CommonAccentButton(
                  title: AppHelpers.getTranslation(TrKeys.save),
                  onPressed: (state.selectedUser == null ||
                          state.selectedAddress == null ||
                          state.selectedPayment == null ||
                          state.selectedCurrency == null)
                      ? null
                      : context.popRoute,
                ),
                40.verticalSpace,
              ],
            ),
          ),
          BlurLoadingWidget(isLoading: state.isUserDetailsLoading),
        ],
      ),
    );
  }
}
