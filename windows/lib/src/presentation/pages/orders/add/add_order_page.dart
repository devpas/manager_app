import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'widgets/client/client_info_modal.dart';
import 'widgets/order_detail/choose_deliveries_modal.dart';
import 'widgets/order_detail/order_detail_info_modal.dart';

class AddOrderPage extends ConsumerWidget {
  const AddOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addOrderProvider);
    final notifier = ref.read(addOrderProvider.notifier);
    return Scaffold(
      appBar: CustomAppbar(
        title: AppHelpers.getTranslation(TrKeys.addOrder),
        leading: SmallIconButton(
          icon: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
            color: AppColors.black,
          ),
          onPressed: context.popRoute,
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            21.verticalSpace,
            OrderEditItem(
              title: AppHelpers.getTranslation(TrKeys.clientInfo),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const ClientInfoModal();
                  },
                );
              },
              isCompleted: state.selectedUser != null &&
                  state.selectedAddress != null &&
                  state.selectedCurrency != null &&
                  state.selectedPayment != null,
            ),
            10.verticalSpace,
            OrderEditItem(
              title: AppHelpers.getTranslation(TrKeys.orderDetailInfo),
              onTap: (state.selectedUser != null &&
                      state.selectedAddress != null &&
                      state.selectedCurrency != null &&
                      state.selectedPayment != null)
                  ? () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const OrderDetailInfoModal();
                        },
                      );
                    }
                  : null,
              isCompleted: state.orderShops.isNotEmpty,
            ),
            10.verticalSpace,
            OrderEditItem(
              title: AppHelpers.getTranslation(TrKeys.chooseDeliveries),
              onTap: (state.selectedUser != null &&
                      state.selectedAddress != null &&
                      state.selectedCurrency != null &&
                      state.selectedPayment != null &&
                      state.orderShops.isNotEmpty)
                  ? () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const ChooseDeliveriesModal(),
                      );
                    }
                  : null,
              isCompleted: state.isDeliveryInfoFilled,
            ),
            const Spacer(),
            CommonAccentButton(
              title: AppHelpers.getTranslation(TrKeys.placeOrder),
              isLoading: state.isCreatingOrder || state.isCreatingPayment,
              onPressed: (state.selectedUser != null &&
                      state.selectedAddress != null &&
                      state.selectedCurrency != null &&
                      state.selectedPayment != null &&
                      state.orderShops.isNotEmpty &&
                      state.isDeliveryInfoFilled)
                  ? () => notifier.makeAnOrder(
                        checkYourNetwork: () {
                          AppHelpers.showCheckFlash(
                            context,
                            AppHelpers.getTranslation(
                                TrKeys.checkYourNetworkConnection),
                          );
                        },
                        goToOrders: context.router.popUntilRoot,
                      )
                  : null,
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
