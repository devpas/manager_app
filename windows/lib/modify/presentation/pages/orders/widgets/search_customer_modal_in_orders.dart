import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/customers/customer_provider.dart';
import 'package:g_manager_app/modify/riverpob/providers/orders/order_provider.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/utils/utils.dart';
import '../../../../../src/riverpod/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class SearchCustomerModalInOrders extends ConsumerStatefulWidget {
  const SearchCustomerModalInOrders({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchCustomerModalInOrders> createState() => _SearchCustomerModalInOrdersState();
}

class _SearchCustomerModalInOrdersState extends ConsumerState<SearchCustomerModalInOrders> {
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
            SearchTextField(
              onChanged: (value) {},
              hintText: AppHelpers.getTranslation(TrKeys.searchUser),
            ),
            10.verticalSpace,
            SearchedItem(
              title: AppHelpers.getTranslation(TrKeys.allUsers),
              isSelected: false,
              onTap: () {
                // notifier.setSelectedUser(null);
                context.popRoute();
              },
            ),
            state.customerLoading!
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
                        final user = state.customers![index];
                        return SearchedItem(
                          title: '${user.name}',
                          isSelected: false,
                          onTap: () {
                            // notifier.setSelectedUser(user);
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
