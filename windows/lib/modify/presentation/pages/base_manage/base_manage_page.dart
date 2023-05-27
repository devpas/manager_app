import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../src/core/constants/constants.dart';
import '../../../../src/core/utils/utils.dart';
import '../../../../src/riverpod/providers/providers.dart';
import '../../../riverpob/providers/base/base_provider.dart';
import '../../components/components.dart';
import '../../theme/theme.dart';
import 'widgets/baseItem.dart';
import 'widgets/products_filter_modal.dart';
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
        ref.read(productsProvider.notifier).updateProducts();
        ref.read(baseProvider.notifier).fetchListBase();
      },
    );
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          ref.read(productsProvider.notifier).fetchProducts();
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
    final state = ref.watch(productsProvider);
    final notifier = ref.read(productsProvider.notifier);
    final stateBase = ref.watch(baseProvider);
    final notifierBase = ref.read(baseProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CustomAppbarPOS(
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
            textEditingController: state.searchController,
            onChanged: notifier.setQuery,
            hintText: "Tên cơ sở",
            suffixIcon: SmallIconButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (context) => const ProductsFilterModal(),
              ),
              icon: Icon(
                FlutterRemix.sound_module_line,
                size: 24.r,
                color: AppColors.black,
              ),
            ),
          ),
          Expanded(
            child: state.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.greenMain,
                      strokeWidth: 3.r,
                    ),
                  )
                : state.products.isEmpty
                    ? Center(
                        child: Text(
                          AppHelpers.getTranslation(TrKeys.thereIsNoProducts),
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
                              bottom: state.isMoreLoading ? 0 : 97,
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
                            )
                        ],
                      ),
          ),
          10.verticalSpace,
          Container(
            color: Colors.white,
            height: 180,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 5, 5),
              child: stateBase.base!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(
                              "${stateBase.base![stateBase.baseSelected!].baseName}"),
                          5.verticalSpace,
                          Text(
                              "${stateBase.base![stateBase.baseSelected!].publicInfomation["address"]}"),
                          const Divider(
                            thickness: 2,
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 70, child: Text("Chủ cs:")),
                              Text(
                                  "${stateBase.base![stateBase.baseSelected!].ownerName}"),
                            ],
                          ),
                          5.verticalSpace,
                          Row(
                            children: [
                              const SizedBox(width: 70, child: Text("Email:")),
                              Text(
                                  "${stateBase.base![stateBase.baseSelected!].email}"),
                            ],
                          ),
                          5.verticalSpace,
                          Row(
                            children: [
                              const SizedBox(width: 70, child: Text("SĐT:")),
                              SizedBox(
                                width: 100,
                                child: Text(
                                    "${stateBase.base![stateBase.baseSelected!].publicInfomation["phone"]}"),
                              ),
                              const SizedBox(
                                  width: 80, child: Text("Diện tích:")),
                              SizedBox(
                                  width: 100,
                                  child: Text(
                                      "${stateBase.base![stateBase.baseSelected!].publicInfomation["area"]}")),
                            ],
                          ),
                          5.verticalSpace,
                          Row(
                            children: [
                              const SizedBox(
                                  width: 70, child: Text("Loại cs:")),
                              SizedBox(
                                  width: 100,
                                  child: Text(
                                      "${stateBase.base![stateBase.baseSelected!].publicInfomation["type_base"]}")),
                              const SizedBox(
                                  width: 80, child: Text("Cây ăn trái:")),
                              SizedBox(
                                  width: 100,
                                  child: Text(
                                      "${stateBase.base![stateBase.baseSelected!].publicInfomation["properties"]["type_tree"][0]["name"]}")),
                            ],
                          ),
                        ])
                  : const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.greenMain,
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
