import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/models.dart';
import 'package:g_manager_app/modify/presentation/pages_dekstop/widgets/drawer_tablet.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';

class TaxCategoriesDesktopPage extends ConsumerStatefulWidget {
  const TaxCategoriesDesktopPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TaxCategoriesDesktopPage> createState() => _TaxCategoriesDesktopPageState();
}

class _TaxCategoriesDesktopPageState extends ConsumerState<TaxCategoriesDesktopPage> with TickerProviderStateMixin {
  late ScrollController _scrollController;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(productsPASProvider.notifier).getListTaxCategories();
      },
    );
  }

  TextEditingController codeController = TextEditingController();

  bool activeCheckBox = true;

  XFile? image;

  int itemIndex = -1;

  bool createMode = false;

  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productsPASProvider);
    final stateBase = ref.watch(baseProvider);
    final notifier = ref.read(productsPASProvider.notifier);
    final notifierBase = ref.read(baseProvider.notifier);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      drawer: const WMainDrawerPosDesktop(),
      appBar: CustomAppbarPOS(
        title: Text(
          stateBase.translate[stateBase.languageSelected]["discount_category"],
          style: AppTypographies.styBlack16W500,
          textAlign: TextAlign.center,
        ),
        leading: Builder(
          builder: (context) => SmallIconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 24.r,
              color: AppColors.black,
            ),
            onPressed: context.popRoute,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          5.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Container(
              height: screenHeight * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(children: [
                  SizedBox(width: screenWidth * 0.28, child: Text("0/${state.taxCategories!.length}")),
                  SizedBox(
                    child: Row(children: [
                      20.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.orderReviews.withOpacity(0.07),
                        iconData: FlutterRemix.skip_back_line,
                        iconColor: AppColors.orderReviews,
                        onTap: () {},
                      ),
                      20.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.orderReviews.withOpacity(0.07),
                        iconData: FlutterRemix.arrow_left_line,
                        iconColor: AppColors.orderReviews,
                        onTap: () {},
                      ),
                      20.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.orderReviews.withOpacity(0.07),
                        iconData: FlutterRemix.arrow_down_line,
                        iconColor: AppColors.orderReviews,
                        onTap: () {},
                      ),
                      20.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.orderReviews.withOpacity(0.07),
                        iconData: FlutterRemix.arrow_right_line,
                        iconColor: AppColors.orderReviews,
                        onTap: () {},
                      ),
                      20.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.orderReviews.withOpacity(0.07),
                        iconData: FlutterRemix.skip_forward_line,
                        iconColor: AppColors.orderReviews,
                        onTap: () {},
                      ),
                      25.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.canceledOrders.withOpacity(0.07),
                        iconData: FlutterRemix.refresh_line,
                        iconColor: AppColors.canceledOrders,
                        onTap: () {
                          print("asd");
                        },
                      ),
                      25.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.blue.withOpacity(0.07),
                        iconData: FlutterRemix.search_2_line,
                        iconColor: AppColors.blue,
                        onTap: () {},
                      ),
                      20.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.greenMain.withOpacity(0.07),
                        iconData: FlutterRemix.sort_desc,
                        iconColor: AppColors.greenMain,
                        onTap: () {},
                      ),
                      20.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: Colors.deepOrange.withOpacity(0.07),
                        iconData: FlutterRemix.add_line,
                        iconColor: Colors.deepOrange,
                        onTap: () {
                          setState(() {
                            createMode = true;
                            nameController.text = "";
                          });
                        },
                      ),
                      20.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: createMode ? Colors.grey.withOpacity(0.07) : AppColors.red.withOpacity(0.07),
                        iconData: FlutterRemix.close_line,
                        iconColor: createMode ? Colors.grey : AppColors.red,
                        onTap: () {
                          if (createMode == false) {
                            notifier.deleteTaxCategory(state.taxCategorySelected["id"]);
                          }
                        },
                      ),
                      25.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.blue.withOpacity(0.07),
                        iconData: FlutterRemix.save_line,
                        iconColor: AppColors.blue,
                        onTap: () {
                          if (createMode) {
                            var taxCategoryData = {
                              "name": nameController.text,
                            };
                            notifier.addTaxCategory(taxCategoryData);
                          } else {
                            var taxCategoryData = {
                              "index": state.taxCategorySelected["index"],
                              "id": state.taxCategorySelected["id"],
                              "name": nameController.text,
                            };
                            notifier.updateTaxCategory(taxCategoryData);
                          }
                          createMode = false;
                        },
                      ),
                      15.horizontalSpace,
                    ]),
                  ),
                ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Container(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.825,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: state.taxCategoryLoading!
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.greenMain,
                            strokeWidth: 3.r,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListView.builder(
                            physics: const CustomBouncingScrollPhysics(),
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: state.taxCategories!.length,
                            itemBuilder: (context, index) {
                              var taxCategory = state.taxCategories![index];
                              taxCategory = state.taxCategories![index];

                              return InkWell(
                                onTap: () {
                                  createMode = false;
                                  itemIndex = index + 1;
                                  notifier.setTaxCategorySelected(taxCategory);
                                  nameController.text = taxCategory["name"];
                                },
                                child: Container(
                                  color: taxCategory["index"] == itemIndex ? Colors.blue : Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.person,
                                              color: Colors.red,
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.25,
                                              child: Text(
                                                taxCategory["name"],
                                                style: TextStyle(color: taxCategory["index"] == itemIndex ? Colors.white : Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
                8.horizontalSpace,
                Column(
                  children: [
                    Container(
                      height: screenHeight * 0.825,
                      width: screenWidth * 0.685,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                SizedBox(width: screenWidth * 0.15, child: const Text("Tên:")),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SizedBox(
                                    width: screenWidth * 0.185,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: nameController,
                                          decoration: const InputDecoration.collapsed(
                                            hintText: '',
                                          ),
                                        ),
                                        const Divider(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
