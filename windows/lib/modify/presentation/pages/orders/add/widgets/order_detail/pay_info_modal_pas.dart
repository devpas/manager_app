import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/presentation/pages/dashboard/widgets/select_user_pos_modal.dart';
import 'package:g_manager_app/modify/riverpob/providers/pos_system_pas/pos_system_pas_provider.dart';

import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';

class PayInfoModal extends ConsumerStatefulWidget {
  const PayInfoModal({Key? key}) : super(key: key);

  @override
  ConsumerState<PayInfoModal> createState() => _PayInfoModalState();
}

class _PayInfoModalState extends ConsumerState<PayInfoModal>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget payment(String title) {
    final state = ref.watch(posSystemPASProvider);
    final notifier = ref.read(posSystemPASProvider.notifier);
    return Material(
      color: AppColors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                SizedBox(
                  height: 400,
                  width: 258,
                  child: ListView(
                    physics: const CustomBouncingScrollPhysics(),
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: 10,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 1,
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) {
                          return Column(children: [
                            TextButton(
                              onPressed: () {},
                              child: Image.network(
                                "https://www.taspen.co.id/assets/img/tjsl/NoImageFound.jpg.png",
                                height: 50,
                                width: 100,
                              ),
                            ),
                            const Text("100"),
                          ]);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.blue,
                  height: 400,
                  width: 138,
                ),
              ],
            ),
          ),
          const BlurLoadingWidget(isLoading: false),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(posSystemPASProvider);
    final notifier = ref.read(posSystemPASProvider.notifier);
    return Column(
      children: [
        10.verticalSpace,
        Text(
          AppHelpers.getTranslation("Thanh toán"),
          style: AppTypographies.styBlack22W500,
        ),
        10.verticalSpace,
        Container(
          color: AppColors.white,
          child: TabBar(
            indicatorColor: AppColors.greenMain,
            indicatorWeight: 2,
            labelPadding: EdgeInsets.zero,
            controller: _tabController,
            labelColor: AppColors.black,
            unselectedLabelColor: AppColors.unselectedTabBar,
            unselectedLabelStyle: AppTypographies.styUnselected14W500,
            labelStyle: AppTypographies.styBlack14W500,
            tabs: [
              Tab(text: AppHelpers.getTranslation("Tiền mặt")),
              Tab(text: AppHelpers.getTranslation("Công nợ")),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const CustomBouncingScrollPhysics(),
            children: [payment("Tiền mặt"), payment("Công nợ")],
          ),
        ),
        30.verticalSpace,
        CommonAccentButton(
            title: AppHelpers.getTranslation(TrKeys.save),
            onPressed: () {
              context.popRoute();
            }),
        30.verticalSpace,
      ],
    );
  }
}
