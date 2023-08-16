import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/presentation/pages/pos/widgets/select_user_pos_modal.dart';
import 'package:g_manager_app/modify/riverpob/providers/pos_system_pas/pos_system_pas_provider.dart';

import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';
import '../../../../pos/widgets/select_address_pos_modal.dart';
import '../../../../pos/widgets/select_currency_modal.dart';
import '../../../../pos/widgets/select_payment_pos_modal.dart';

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
        // ref.read(addOrderProvider.notifier).fetchCurrencies(
        //   checkYourNetwork: () {
        //     AppHelpers.showCheckFlash(
        //       context,
        //       AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        //     );
        //   },
        // );
        // ref.read(addOrderProvider.notifier).fetchPayments(
        //   checkYourNetwork: () {
        //     AppHelpers.showCheckFlash(
        //       context,
        //       AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        //     );
        //   },
        // );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(posSystemPASProvider);
    final notifier = ref.read(posSystemPASProvider.notifier);
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
                  AppHelpers.getTranslation("Khách hàng"),
                  style: AppTypographies.styBlack22W500,
                ),
                59.verticalSpace,
                SelectWithAddButton(
                  label: AppHelpers.getTranslation("Khách hàng"),
                  title: state.infoSelected!.isNotEmpty
                      ? state.infoSelected![0][1]
                      : "Tên người dùng",
                  onSelectTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const SelectUserPosModal();
                      },
                    );
                  },
                ),
                Padding(
                  padding: REdgeInsets.only(top: 30.0),
                  child: SelectWithAddButton(
                    label: AppHelpers.getTranslation("Địa chỉ"),
                    title: state.infoSelected!.isEmpty
                        ? "địa chỉ"
                        : state.infoSelected![0][2],
                    onSelectTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => const SelectAddressPosModal(),
                    ),
                  ),
                ),
                30.verticalSpace,
                SelectWithAddButton(
                  label: AppHelpers.getTranslation("Đơn vị tiền tệ"),
                  title: state.infoSelected!.isNotEmpty
                      ? state.infoSelected![1][2]
                      : "Chọn loại tiền",
                  onSelectTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const SelectCurrencyPosModal(),
                    );
                  },
                ),
                30.verticalSpace,
                SelectWithAddButton(
                  label: AppHelpers.getTranslation("Phương thức thanh toán"),
                  title: state.infoSelected!.isNotEmpty
                      ? state.infoSelected![2][1]
                      : "Chọn phương thức",
                  onSelectTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const SelectPaymentPosModal(),
                    );
                  },
                ),
                93.verticalSpace,
                CommonAccentButton(
                    title: AppHelpers.getTranslation(TrKeys.save),
                    onPressed: () {
                      context.popRoute();
                    }),
                40.verticalSpace,
              ],
            ),
          ),
          const BlurLoadingWidget(isLoading: false),
        ],
      ),
    );
  }
}
