import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/base/base_provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/routes/app_router.gr.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';

class BaseListEmployee extends ConsumerStatefulWidget {
  const BaseListEmployee({Key? key}) : super(key: key);

  @override
  ConsumerState<BaseListEmployee> createState() => _BaseListEmployeeState();
}

class _BaseListEmployeeState extends ConsumerState<BaseListEmployee> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(baseProvider.notifier).getListEmployee();
      },
    );
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          ref.read(editUserProvider.notifier).fetchUserOrders(
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
    final state = ref.watch(baseProvider);
    final notifier = ref.read(baseProvider.notifier);
    return state.employeesLoading!
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.greenMain,
              strokeWidth: 3.r,
            ),
          )
        : state.employees!.isEmpty
            ? Center(
                child: Text(
                  AppHelpers.getTranslation(TrKeys.thereIsNoOrdersForThisUser),
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.4,
                  ),
                ),
              )
            : Scaffold(
                floatingActionButton: FloatingActionButton(
                  backgroundColor: AppColors.greenMain,
                  onPressed: () {
                    context.pushRoute(AddEmployeeRoute());
                  },
                  child: Icon(
                    FlutterRemix.add_line,
                    size: 20.r,
                    color: AppColors.white,
                  ),
                ),
                body: ListView(
                  physics: const CustomBouncingScrollPhysics(),
                  controller: _scrollController,
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: REdgeInsets.only(
                          left: 15, right: 15, top: 14, bottom: 20),
                      itemCount: state.employees!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final employees = state.employees![index];
                        return EmployeeItem(
                          background: AppColors.mainBackground,
                          employee: employees,
                          onEdit: () {
                            context.pushRoute(
                                EditEmployeeRoute(employee: employees));
                          },
                          onDelete: () {
                            notifier.deleteEmployee(employees.email!);
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
  }
}
