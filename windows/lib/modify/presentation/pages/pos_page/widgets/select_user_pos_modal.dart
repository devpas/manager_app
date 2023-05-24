import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/pos_system_pas/pos_system_pas_provider.dart';

import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class SelectUserPosModal extends ConsumerStatefulWidget {
  const SelectUserPosModal({Key? key}) : super(key: key);

  @override
  ConsumerState<SelectUserPosModal> createState() =>
      _SearchUserModalInClientInfoState();
}

class _SearchUserModalInClientInfoState
    extends ConsumerState<SelectUserPosModal> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(posSystemPASProvider);
    final notifier = ref.read(posSystemPASProvider.notifier);
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
              // onChanged: (value) =>
              //     notifier.setUserQuery(context, value.trim()),
              hintText: AppHelpers.getTranslation(TrKeys.searchUser),
            ),
            10.verticalSpace,
            state.isUsersLoading
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
                      itemCount: state.customerPos!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final user = state.customerPos![index];
                        return SearchedItem(
                          title: '${user[1]}',
                          isSelected: state.infoSelected![0][0] == user[0],
                          onTap: () {
                            notifier.setSelectUserPos(user);
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
