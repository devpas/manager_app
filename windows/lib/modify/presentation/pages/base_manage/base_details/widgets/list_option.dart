import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../src/core/constants/constants.dart';
import '../../../../../../src/core/utils/utils.dart';
import '../../../../../../src/riverpod/providers/providers.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';
import 'sub_page/wallet_history_item.dart';

class ListOption extends ConsumerStatefulWidget {
  const ListOption({Key? key}) : super(key: key);

  @override
  ConsumerState<ListOption> createState() => _ListOptionState();
}

class _ListOptionState extends ConsumerState<ListOption> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(editUserProvider.notifier).fetchWalletHistories(
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
    final state = ref.watch(editUserProvider);
    return state.isLoadingWallet
        ? Center(
            child: CircularProgressIndicator(
              strokeWidth: 3.r,
              color: AppColors.greenMain,
            ),
          )
        : state.walletHistories.isEmpty
            ? Center(
                child: Text(
                  AppHelpers.getTranslation(TrKeys.noWallet),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: AppColors.black,
                    letterSpacing: -0.4,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: state.walletHistories.length,
                shrinkWrap: true,
                physics: const CustomBouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    ListOptionItem(wallet: state.walletHistories[index]),
              );
  }
}
