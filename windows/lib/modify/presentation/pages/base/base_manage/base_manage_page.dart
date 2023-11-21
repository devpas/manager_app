import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/src/core/constants/app_constants.dart';
import 'package:g_manager_app/src/core/routes/app_router.gr.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../riverpob/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'widgets/baseEmployeeItem.dart';
import 'widgets/baseItem.dart';
import 'widgets/w_delete_product_dialog.dart';

class BaseManagePage extends ConsumerStatefulWidget {
  const BaseManagePage({Key? key}) : super(key: key);

  @override
  ConsumerState<BaseManagePage> createState() => _BaseManagePageState();
}

class _BaseManagePageState extends ConsumerState<BaseManagePage> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.delayed(
      Duration.zero,
      () {
        ref.read(baseProvider.notifier).fetchListBase();
        ref.read(baseProvider.notifier).fetchListBaseEmployee();
      },
    );
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {},
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Widget shareBaseTab() {
    final stateBase = ref.watch(baseProvider);
    final notifierBase = ref.read(baseProvider.notifier);
    return Column(
      children: [
        SearchTextField(
          onChanged: (input) {
            notifierBase.filterBaseByNameOrEmail(input);
          },
          hintText: "Tên cơ sở hoặc email",
          suffixIcon: SmallIconButton(
            onPressed: () {
              notifierBase.fetchListBase();
            },
            icon: Icon(
              FlutterRemix.refresh_line,
              size: 24.r,
              color: AppColors.black,
            ),
          ),
        ),
        Expanded(
          child: stateBase.baseLoading!
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.greenMain,
                    strokeWidth: 3.r,
                  ),
                )
              : stateBase.base!.isEmpty
                  ? Center(
                      child: Text(
                        "Không tìm thấy cơ sở",
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
                          padding: REdgeInsets.all(8),
                          shrinkWrap: true,
                          itemCount: stateBase.base!.length,
                          itemBuilder: (context, index) {
                            final base = stateBase.base![index];
                            print(base.moneyRecord);
                            return BaseItem(
                              active: notifierBase.checkActiveBase(base.keyAccess!),
                              base: base,
                              onTap: () async {
                                notifierBase.updateBaseSelected(index);
                              },
                              onSwitch: () {
                                if (notifierBase.checkActiveBase(base.keyAccess!)) {
                                } else {
                                  notifierBase.switchBase(base);
                                }
                              },
                              onEdit: () {
                                context.pushRoute(
                                  BaseDetailsRoute(
                                    base: base,
                                    from: OpenEditUserFrom.users,
                                  ),
                                );
                              },
                              onDeleteTap: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return WDeleteProductDialog(
                                      uuid: base.keyAccess ?? '',
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
        ),
        10.verticalSpace,
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: stateBase.base!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 5, 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    ExpansionTile(title: const Text("Danh sách quyền truy cập"), textColor: AppColors.greenMain, initiallyExpanded: true, children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: stateBase.base![stateBase.baseSelected!].listRoleBlock!.length,
                        itemBuilder: (context, index) {
                          var role = stateBase.base![stateBase.baseSelected!].listRoleBlock![index];
                          return Text(
                            "${role.block}: ${role.role}",
                            style: AppTypographies.styBlack13W500,
                          );
                        },
                      ),
                      10.verticalSpace,
                    ]),
                    5.verticalSpace,
                    Row(
                      children: [
                        const SizedBox(width: 70, child: Text("Email")),
                        SizedBox(
                          child: Text("${stateBase.base![stateBase.baseSelected!].email}"),
                        ),
                      ],
                    ),
                    5.verticalSpace,
                    Row(
                      children: [
                        const SizedBox(width: 70, child: Text("Địa chỉ")),
                        Expanded(
                          child: Text("${stateBase.base![stateBase.baseSelected!].address}"),
                        ),
                      ],
                    ),
                    5.verticalSpace,
                    Row(
                      children: [
                        const SizedBox(width: 70, child: Text("Loại cs")),
                        SizedBox(width: 150, child: Text("${stateBase.base![stateBase.baseSelected!].baseType}")),
                        const SizedBox(width: 70, child: Text("SĐT")),
                        SizedBox(width: 100, child: Text("${stateBase.base![stateBase.baseSelected!].phone}")),
                      ],
                    ),
                  ]),
                )
              : const SizedBox(),
        )
      ],
    );
  }

  Widget employeeBaseTab() {
    final stateBase = ref.watch(baseProvider);
    final notifierBase = ref.read(baseProvider.notifier);
    return Column(
      children: [
        SearchTextField(
          onChanged: (input) {
            notifierBase.filterBaseByNameOrEmail(input);
          },
          hintText: "Tên cơ sở hoặc email",
          suffixIcon: SmallIconButton(
            onPressed: () {
              notifierBase.fetchListBase();
            },
            icon: Icon(
              FlutterRemix.refresh_line,
              size: 24.r,
              color: AppColors.black,
            ),
          ),
        ),
        Expanded(
          child: stateBase.baseLoading!
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.greenMain,
                    strokeWidth: 3.r,
                  ),
                )
              : stateBase.baseEmployees!.isEmpty
                  ? Center(
                      child: Text(
                        "Không tìm thấy cơ sở",
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
                          padding: REdgeInsets.all(8),
                          shrinkWrap: true,
                          itemCount: stateBase.baseEmployees!.length,
                          itemBuilder: (context, index) {
                            final base = stateBase.baseEmployees![index];
                            return BaseEmployeeItem(
                              base: base,
                              onTap: () async {
                                notifierBase.updateBaseSelected(index);
                              },
                              onEdit: () {
                                context.pushRoute(
                                  BaseDetailsRoute(
                                    base: base,
                                    from: OpenEditUserFrom.users,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
        ),
        10.verticalSpace,
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: stateBase.base!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 5, 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    ExpansionTile(title: const Text("Danh sách quyền truy cập"), textColor: AppColors.greenMain, initiallyExpanded: true, children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: stateBase.base![stateBase.baseSelected!].listRoleBlock!.length,
                        itemBuilder: (context, index) {
                          var role = stateBase.base![stateBase.baseSelected!].listRoleBlock![index];
                          return Text(
                            "${role.block}: ${role.role}",
                            style: AppTypographies.styBlack13W500,
                          );
                        },
                      ),
                      10.verticalSpace,
                    ]),
                    5.verticalSpace,
                    Row(
                      children: [
                        const SizedBox(width: 70, child: Text("Email")),
                        SizedBox(
                          child: Text("${stateBase.base![stateBase.baseSelected!].email}"),
                        ),
                      ],
                    ),
                    5.verticalSpace,
                    Row(
                      children: [
                        const SizedBox(width: 70, child: Text("Địa chỉ")),
                        Expanded(
                          child: Text("${stateBase.base![stateBase.baseSelected!].address}"),
                        ),
                      ],
                    ),
                    5.verticalSpace,
                    Row(
                      children: [
                        const SizedBox(width: 70, child: Text("Loại cs")),
                        SizedBox(width: 150, child: Text("${stateBase.base![stateBase.baseSelected!].baseType}")),
                        const SizedBox(width: 70, child: Text("SĐT")),
                        SizedBox(width: 100, child: Text("${stateBase.base![stateBase.baseSelected!].phone}")),
                      ],
                    ),
                  ]),
                )
              : const SizedBox(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CustomAppbarPOS(
          center: true,
          title: Text(
            "QUẢN LÝ CƠ SỞ",
            style: AppTypographies.styBlack12W400,
          ),
          leading: Builder(
            builder: (context) => SmallIconButton(
              icon: Icon(
                FlutterRemix.arrow_left_s_line,
                size: 24.r,
                color: AppColors.black,
              ),
              onPressed: context.popRoute,
            ),
          ),
          // actions: getBaseActions(context)
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
              tabs: const [
                Tab(text: "Cơ sở được chia sẻ"),
                Tab(text: "Cơ sở nhân viên"),
              ],
            ),
          ),
          18.verticalSpace,
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const CustomBouncingScrollPhysics(),
              children: [shareBaseTab(), employeeBaseTab()],
            ),
          ),
          3.verticalSpace,
        ],
      ),
    );
  }
}
