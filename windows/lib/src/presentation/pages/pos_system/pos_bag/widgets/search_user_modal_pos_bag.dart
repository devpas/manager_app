import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../riverpod/providers/providers.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';

class SearchUserModalInPosBag extends ConsumerStatefulWidget {
  const SearchUserModalInPosBag({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchUserModalInPosBag> createState() =>
      _SearchUserModalInPosBagState();
}

class _SearchUserModalInPosBagState
    extends ConsumerState<SearchUserModalInPosBag> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(posBagProvider.notifier).fetchUsers(
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
    final state = ref.watch(posBagProvider);
    final notifier = ref.read(posBagProvider.notifier);
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
                  notifier.setUserQuery(context, value.trim()),
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
                      itemCount: state.users.length,
                      shrinkWrap: true,
                      controller: ModalScrollController.of(context),
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return SearchedItem(
                          title: '${user.firstname} ${user.lastname}',
                          isSelected:
                              user.id == state.posBagData?.selectedUser?.id,
                          onTap: () {
                            notifier.setSelectedUser(
                              context,
                              ref.read(posSystemProvider.notifier),
                              user,
                            );
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
