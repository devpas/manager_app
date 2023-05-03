import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../core/utils/utils.dart';
import '../../../riverpod/providers/providers.dart';
import '../../components/components.dart';
import '../../theme/theme.dart';
import 'widgets/delivery_man_item_widget.dart';
import 'widgets/user_roles_modal.dart';

class DeliveryBoyPage extends ConsumerStatefulWidget {
  const DeliveryBoyPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DeliveryBoyPage> createState() => _DeliveryBoyPageState();
}

class _DeliveryBoyPageState extends ConsumerState<DeliveryBoyPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(deliveryBoysProvider.notifier).fetchDeliveryMen(
          checkYourNetwork: () {
            AppHelpers.showCheckFlash(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
      },
    );
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          ref.read(deliveryBoysProvider.notifier).fetchDeliveryMen(
            checkYourNetwork: () {
              AppHelpers.showCheckFlash(
                context,
                AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
              );
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(deliveryBoysProvider);
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: state.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.greenMain,
                strokeWidth: 3.r,
              ),
            )
          : state.deliverymen.isEmpty
              ? Center(
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.thereIsNoDeliveryBoys),
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : ListView(
                  physics: const CustomBouncingScrollPhysics(),
                  controller: _scrollController,
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: REdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 14,
                        bottom: state.isMoreLoading ? 0 : 97,
                      ),
                      itemCount: state.deliverymen.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final deliveryMan = state.deliverymen[index];
                        return DeliveryManItemWidget(
                          deliveryman: deliveryMan,
                          onEditRoleTap: () => showModalBottomSheet(
                            context: context,
                            builder: (context) =>
                                UserRolesModal(userData: deliveryMan),
                          ),
                          onEditUserTap: () {
                            context.pushRoute(
                              EditUserRoute(
                                uuid: deliveryMan.uuid,
                                title:
                                    '${deliveryMan.firstname ?? ''} ${deliveryMan.lastname ?? ''}',
                                from: OpenEditUserFrom.deliveryBoys,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    if (state.isMoreLoading)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: CircularProgressIndicator(
                              color: AppColors.greenMain,
                              strokeWidth: 2.r,
                            ),
                          ),
                          127.verticalSpace,
                        ],
                      ),
                  ],
                ),
    );
  }
}
