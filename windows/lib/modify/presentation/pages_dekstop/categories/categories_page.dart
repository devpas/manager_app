import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/data/customer_data.dart';
import 'package:g_manager_app/modify/models/models.dart';
import 'package:g_manager_app/modify/presentation/pages_dekstop/widgets/drawer_tablet.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/components.dart';
import '../../pages/categories/widgets/w_delete_category_dialog.dart';
import '../../theme/theme.dart';

class CategoriesDesktopPage extends ConsumerStatefulWidget {
  const CategoriesDesktopPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoriesDesktopPage> createState() => _CategoriesDesktopPageState();
}

class _CategoriesDesktopPageState extends ConsumerState<CategoriesDesktopPage> with TickerProviderStateMixin {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(categoriesPASProvider.notifier).fetchCategoriesAppscript();
      },
    );
  }

  bool activeCheckBox = true;

  bool createMode = false;

  int indexItemSelected = -1;

  TextEditingController nameController = TextEditingController();

  int categoryIdSelected = -1;

  void loadCategoryData(CategoryPasData category) {
    print(category.toJson());
    setState(() {
      createMode = false;
      nameController.text = category.name!;
      categoryIdSelected = category.parentId!;
    });
  }

  void saveCategory() {
    final notifier = ref.read(categoriesPASProvider.notifier);
    final state = ref.watch(categoriesPASProvider);
    if (createMode) {
      var dataCategory = {"name": nameController.text, "parent_id": categoryIdSelected, "image": "", "active": 1};
      notifier.addCategory(dataCategory);
    } else {
      var dataCategory = {"id": state.categorySelected!.id, "name": nameController.text, "parent_id": categoryIdSelected, "image": "", "active": state.categorySelected!.active};
      notifier.updateCategory(dataCategory);
    }
    newCategory();
  }

  void newCategory() {
    setState(() {
      createMode = true;
      nameController.text = "";
      categoryIdSelected = -1;
      indexItemSelected = -1;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoriesPASProvider);
    final stateBase = ref.watch(baseProvider);
    final notifier = ref.read(categoriesPASProvider.notifier);
    final notifierBase = ref.read(baseProvider.notifier);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      drawer: const WMainDrawerPosDesktop(),
      appBar: CustomAppbarPOS(
        title: Text(
          stateBase.translate[stateBase.languageSelected]["title_categories"],
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
                  SizedBox(width: screenWidth * 0.28, child: Text("0/${state.categories!.length}")),
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
                          notifier.fetchCategoriesAppscript();
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
                          newCategory();
                        },
                      ),
                      20.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.red.withOpacity(0.07),
                        iconData: FlutterRemix.close_line,
                        iconColor: AppColors.red,
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return WDeleteCategoryDialog(
                                alias: state.categorySelected!.id!,
                              );
                            },
                          );
                        },
                      ),
                      25.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.blue.withOpacity(0.07),
                        iconData: FlutterRemix.save_line,
                        iconColor: AppColors.blue,
                        onTap: () {
                          saveCategory();
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
                  child: state.categoryLoading!
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
                            itemCount: state.categoriesAfterFilter!.isEmpty ? state.categories!.length : state.categoriesAfterFilter!.length,
                            itemBuilder: (context, index) {
                              CategoryPasData category;
                              if (state.categoriesAfterFilter!.isEmpty) {
                                category = state.categories![index];
                              } else {
                                category = state.categoriesAfterFilter![index];
                              }
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    indexItemSelected = index;
                                  });
                                  loadCategoryData(category);
                                  notifier.setCategorySelected(category);
                                },
                                child: Container(
                                  color: index == indexItemSelected ? Colors.blue : Colors.white,
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
                                                category.name!,
                                                style: TextStyle(color: index == indexItemSelected ? Colors.white : Colors.black),
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
                                SizedBox(width: screenWidth * 0.1, child: const Text("Tên:")),
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
                                (screenWidth * 0.1).horizontalSpace,
                                IconTextButton(
                                  backgroundColor: AppColors.blue.withOpacity(0.07),
                                  iconData: FlutterRemix.delete_bin_fill,
                                  iconColor: AppColors.blue,
                                  title: "Thêm vào danh mục",
                                  textColor: AppColors.blue,
                                  onPressed: () {
                                    // notifierBase.loadTranslate();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                SizedBox(width: screenWidth * 0.1, child: const Text("Cấp trên:")),
                                SizedBox(
                                  width: screenWidth * 0.185,
                                  child: Column(
                                    children: [
                                      DropdownButton(
                                          value: categoryIdSelected == 0 ? state.categories![0] : state.categories!.where((e) => e.id == categoryIdSelected).first,
                                          items: state.categories!.map<DropdownMenuItem<CategoryPasData>>((CategoryPasData value) {
                                            return DropdownMenuItem<CategoryPasData>(
                                              value: value,
                                              child: SizedBox(width: screenWidth * 0.160, child: Text(value.name!)),
                                            );
                                          }).toList(),
                                          onChanged: (e) {
                                            setState(() {
                                              categoryIdSelected = int.parse(e!.id!.toString());
                                              print("asdasd $categoryIdSelected");
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                                (screenWidth * 0.1).horizontalSpace,
                                IconTextButton(
                                  backgroundColor: AppColors.blue.withOpacity(0.07),
                                  iconData: FlutterRemix.delete_bin_fill,
                                  iconColor: AppColors.blue,
                                  title: "Xóa khỏi danh mục",
                                  textColor: AppColors.blue,
                                  onPressed: () {
                                    // notifierBase.loadTranslate();
                                  },
                                ),
                              ],
                            ),
                          ),
                          10.verticalSpace,
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 10),
                          //   child: Column(
                          //     children: [
                          //       Row(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           SizedBox(width: screenWidth * 0.1, child: const Text("Hình ảnh:")),
                          //           Align(
                          //             alignment: Alignment.center,
                          //             child: SelectImageCustomeSize(
                          //               file: image,
                          //               heigth: screenHeight * 0.35,
                          //               width: screenWidth * 0.2,
                          //               onChangePhoto: (XFile file) {
                          //                 setState(() {
                          //                   image = file;
                          //                 });
                          //               },
                          //             ),
                          //           ),
                          //           10.horizontalSpace,
                          //           Column(
                          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               CircleIconButton(
                          //                 backgroundColor: AppColors.blue.withOpacity(0.1),
                          //                 iconData: FlutterRemix.folder_2_line,
                          //                 iconColor: AppColors.blue,
                          //                 onTap: () {},
                          //               ),
                          //               10.verticalSpace,
                          //               CircleIconButton(
                          //                 backgroundColor: AppColors.blue.withOpacity(0.1),
                          //                 iconData: FlutterRemix.close_line,
                          //                 iconColor: AppColors.blue,
                          //                 onTap: () {},
                          //               ),
                          //               10.verticalSpace,
                          //               CircleIconButton(
                          //                 backgroundColor: AppColors.blue.withOpacity(0.1),
                          //                 iconData: FlutterRemix.file_search_line,
                          //                 iconColor: AppColors.blue,
                          //                 onTap: () {},
                          //               ),
                          //               10.verticalSpace,
                          //               CircleIconButton(
                          //                 backgroundColor: AppColors.blue.withOpacity(0.1),
                          //                 iconData: FlutterRemix.zoom_in_line,
                          //                 iconColor: AppColors.blue,
                          //                 onTap: () {},
                          //               ),
                          //               10.verticalSpace,
                          //               CircleIconButton(
                          //                 backgroundColor: AppColors.blue.withOpacity(0.1),
                          //                 iconData: FlutterRemix.zoom_out_line,
                          //                 iconColor: AppColors.blue,
                          //                 onTap: () {},
                          //               ),
                          //             ],
                          //           )
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // )
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
