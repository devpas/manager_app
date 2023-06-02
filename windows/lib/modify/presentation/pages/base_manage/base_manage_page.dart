import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../src/riverpod/providers/providers.dart';
import '../../../riverpob/providers/base/base_provider.dart';
import '../../components/components.dart';
import '../../theme/theme.dart';
import 'widgets/baseItem.dart';
import 'widgets/w_delete_product_dialog.dart';

class BaseManagePage extends ConsumerStatefulWidget {
  const BaseManagePage({Key? key}) : super(key: key);

  @override
  ConsumerState<BaseManagePage> createState() => _BaseManagePageState();
}

class _BaseManagePageState extends ConsumerState<BaseManagePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(baseProvider.notifier).fetchListBase();
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

  @override
  Widget build(BuildContext context) {
    final stateBase = ref.watch(baseProvider);
    final notifierBase = ref.read(baseProvider.notifier);
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
            actions: getBaseActions(context)),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          3.verticalSpace,
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
                            padding: REdgeInsets.only(
                              top: 20,
                              left: 15,
                              right: 15,
                              bottom: 10,
                            ),
                            shrinkWrap: true,
                            itemCount: stateBase.base!.length,
                            itemBuilder: (context, index) {
                              final base = stateBase.base![index];
                              return BaseItem(
                                base: base,
                                onTap: () async {
                                  notifierBase.updateBaseSelected(index);
                                },
                                onSwitch: () {
                                  print("onSwitch");
                                },
                                onEdit: () {
                                  print("edit");
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExpansionTile(
                              title: const Text("Danh sách quyền truy cập"),
                              textColor: AppColors.greenMain,
                              initiallyExpanded: true,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: stateBase
                                      .base![stateBase.baseSelected!]
                                      .listRole!
                                      .length,
                                  itemBuilder: (context, index) {
                                    var role = stateBase
                                        .base![stateBase.baseSelected!]
                                        .listRole![index];
                                    return Text(
                                      "${role["name"]}-${role["area"]}",
                                      style: AppTypographies.styBlack13W500,
                                    );
                                  },
                                ),
                                10.verticalSpace,
                              ]),
                          5.verticalSpace,
                          Row(
                            children: [
                              const SizedBox(width: 70, child: Text("Địa chỉ")),
                              Expanded(
                                child: Text(
                                    "${stateBase.base![stateBase.baseSelected!].publicInfomation["address"]}"),
                              ),
                            ],
                          ),
                          5.verticalSpace,
                          Row(
                            children: [
                              const SizedBox(width: 70, child: Text("SĐT")),
                              SizedBox(
                                width: 100,
                                child: Text(
                                    "${stateBase.base![stateBase.baseSelected!].publicInfomation["phone"]}"),
                              ),
                              const SizedBox(
                                  width: 80, child: Text("Diện tích")),
                              SizedBox(
                                  width: 100,
                                  child: Text(
                                      "${stateBase.base![stateBase.baseSelected!].publicInfomation["area"]}")),
                            ],
                          ),
                          5.verticalSpace,
                          Row(
                            children: [
                              const SizedBox(width: 70, child: Text("Loại cs")),
                              SizedBox(
                                  width: 100,
                                  child: Text(
                                      "${stateBase.base![stateBase.baseSelected!].publicInfomation["type_base"]}")),
                              const SizedBox(
                                  width: 80, child: Text("Sản phẩm")),
                              SizedBox(
                                  width: 100,
                                  child: Text(
                                      "${stateBase.base![stateBase.baseSelected!].publicInfomation["properties"]["type_tree"][0]["name"]}")),
                            ],
                          ),
                        ]),
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
