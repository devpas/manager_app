import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/customers/customer_provider.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';

import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class SelectUserPosModal extends ConsumerStatefulWidget {
  const SelectUserPosModal({Key? key}) : super(key: key);

  @override
  ConsumerState<SelectUserPosModal> createState() => _SearchUserModalInClientInfoState();
}

class _SearchUserModalInClientInfoState extends ConsumerState<SelectUserPosModal> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(customersProvider.notifier).fetchListCustomers();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final statePos = ref.watch(posSystemPASProvider);
    final notifierPos = ref.read(posSystemPASProvider.notifier);
    final state = ref.watch(customersProvider);
    final notifier = ref.read(customersProvider.notifier);
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
            const SearchTextField(
              // onChanged: (value) =>
              //     notifier.setUserQuery(context, value.trim()),
              hintText: "Tìm khách hàng",
            ),
            10.verticalSpace,
            state.customers!.isEmpty
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
                      itemCount: state.customers!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final customer = state.customers![index];
                        if (customer.visible == 1) {
                          return SearchedItem(
                            title: '${customer.name}',
                            isSelected: false,
                            onTap: () {
                              var customerPos = [customer.id, customer.name, customer.address, customer.fileOrdersId ?? "", customer.taxCategory];
                              notifierPos.setSelectUserPos(customerPos);
                              notifier.selectCustomer(statePos.infoSelected![0][0]);
                              context.popRoute();
                            },
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
