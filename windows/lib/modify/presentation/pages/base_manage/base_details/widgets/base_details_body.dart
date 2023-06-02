import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';
import 'sub_page/base_type_modal.dart';

class BaseDetailsBody extends ConsumerWidget {
  final OpenEditUserFrom from;

  const BaseDetailsBody({Key? key, required this.from}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editUserProvider);
    final notifier = ref.read(editUserProvider.notifier);
    return state.isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.greenMain,
              strokeWidth: 3.r,
            ),
          )
        : SingleChildScrollView(
            physics: const CustomBouncingScrollPhysics(),
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.verticalSpace,
                  Align(
                    alignment: Alignment.center,
                    child: SelectImage(
                      imageUrl: state.imageUrl,
                      file: state.image,
                      onChangePhoto: notifier.setImage,
                    ),
                  ),
                  38.verticalSpace,
                  CommonInputField(
                    initialValue: state.firstname,
                    label: "Tên cơ sở",
                    onChanged: notifier.setFirstname,
                    inputType: TextInputType.name,
                  ),
                  30.verticalSpace,
                  CommonInputField(
                    initialValue: state.lastname,
                    label: "Chủ sở hữu",
                    onChanged: notifier.setLastname,
                    inputType: TextInputType.name,
                  ),
                  30.verticalSpace,
                  CommonInputField(
                    initialValue: state.email,
                    label: AppHelpers.getTranslation(TrKeys.email),
                    onChanged: notifier.setEmail,
                    inputType: TextInputType.emailAddress,
                  ),
                  30.verticalSpace,
                  CommonInputField(
                    initialValue: state.phone,
                    label: AppHelpers.getTranslation(TrKeys.phone),
                    onChanged: notifier.setPhone,
                    inputType: TextInputType.phone,
                  ),
                  30.verticalSpace,
                  SelectWithSearchButton(
                    label: "Loại cơ sở",
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => const BaseTypesModal(
                        baseTypeActive: "Trồng trọt",
                      ),
                    ),
                    title: "Trồng trọt",
                  ),
                  30.verticalSpace,
                  CommonAccentButton(
                    title: AppHelpers.getTranslation(TrKeys.save),
                    onPressed: () => notifier.updateUser(
                      checkYourNetwork: () {
                        AppHelpers.showCheckFlash(
                          context,
                          AppHelpers.getTranslation(
                              TrKeys.checkYourNetworkConnection),
                        );
                      },
                      afterUpdating: () {
                        context.popRoute();
                        switch (from) {
                          case OpenEditUserFrom.deliveryBoys:
                            ref
                                .read(deliveryBoysProvider.notifier)
                                .updateDeliveryMen(context);
                            break;
                          case OpenEditUserFrom.dashboard:
                            ref
                                .read(dashboardProvider.notifier)
                                .updateCustomers(context);
                            break;
                          case OpenEditUserFrom.users:
                            ref
                                .read(usersProvider.notifier)
                                .updateUsers(context);
                            break;
                        }
                      },
                    ),
                    isLoading: state.isSaving,
                  ),
                  30.verticalSpace,
                ],
              ),
            ),
          );
  }
}
