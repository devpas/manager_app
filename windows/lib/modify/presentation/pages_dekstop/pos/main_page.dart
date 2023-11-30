import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../src/core/utils/utils.dart';
import '../../../riverpob/providers/providers.dart';
import '../../components/components.dart';
import '../../pages/pos/pos_manage/products_manage/products/widgets/product_item_pos.dart';
import '../../pages/pos/widgets/product_short_infomation_modal.dart';
import '../../theme/theme.dart';

class MainPageDeskTop extends ConsumerStatefulWidget {
  const MainPageDeskTop({Key? key}) : super(key: key);

  @override
  ConsumerState<MainPageDeskTop> createState() => _MainPageDeskTopState();
}

class _MainPageDeskTopState extends ConsumerState<MainPageDeskTop> {
  String message = "";
  bool keyboardVisible = false;
  late FocusNode focusNode;
  bool keyboardActive = false;
  double heightContainerProduct = 40;

  int reasonSelected = -1;

  void showKeyboard() {
    focusNode.requestFocus();
    setState(() {
      keyboardVisible = true;
    });
  }

  void dismissKeyboard() {
    focusNode.unfocus();
    setState(() {
      keyboardVisible = false;
    });
  }

  double setHeighProductContainer(double height) {
    setState(() {
      if (keyboardActive) {
        heightContainerProduct = height * 0.1;
      } else {
        heightContainerProduct = height * 0.425;
      }
    });
    return heightContainerProduct;
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    KeyboardVisibilityController().onChange.listen((isVisible) {
      setState(() {
        if (isVisible) {
          keyboardActive = true;
        } else {
          keyboardActive = false;
        }
      });
    });
    Future.delayed(
      Duration.zero,
      () {
        ref.read(categoriesPASProvider.notifier).fetchCategoriesAppscript();
        ref.read(productsPASProvider.notifier).fetchProductsPos();
        ref.read(productsPASProvider.notifier).getListTaxes();
        ref.read(posSystemPASProvider.notifier).initListTicket();
        ref.read(productsPASProvider.notifier).getListWarehouses();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final stateCategories = ref.watch(categoriesPASProvider);
    final stateProducts = ref.watch(productsPASProvider);
    final statePos = ref.watch(posSystemPASProvider);
    final stateBase = ref.watch(baseProvider);
    final notifierPos = ref.read(posSystemPASProvider.notifier);
    final notifierCategories = ref.read(categoriesPASProvider.notifier);
    final notifierProducts = ref.read(productsPASProvider.notifier);
    final notifierBase = ref.read(baseProvider.notifier);
    final stateCustomer = ref.watch(customersProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.mainBack,
      drawer: Drawer(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 15, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CommonImage(
                    imageUrl: "https://www.clipartmax.com/png/full/319-3191274_male-avatar-admin-profile.png",
                    width: 50.r,
                    height: 50.r,
                    radius: 25,
                  ),
                  16.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'user last name',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -14 * 0.02,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        'role',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -14 * 0.02,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconTextButton(
                backgroundColor: AppColors.red.withOpacity(0.07),
                iconData: FlutterRemix.delete_bin_fill,
                iconColor: AppColors.red,
                title: AppHelpers.getTranslation("logout"),
                textColor: AppColors.red,
                onPressed: () {
                  // LocalStorage.instance.deleteToken();
                  // LocalStorage.instance.deleteUser();
                  // LocalStorage.instance.deleteCartProducts();
                  // context.replaceRoute(const LoginRoute());
                },
              ),
            ],
          ),
        ),
      ),
      // endDrawer: DeliveriesDrawer(bagShops: rightSideState.bagShops),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            30.verticalSpace,
            const SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 700, child: Center(child: Text("POS -abc"))),
                  Text("Logo"),
                ],
              ),
            ),
            Row(
              children: [
                Material(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.white,
                  child: Builder(
                    builder: (BuildContext context) => InkWell(
                      borderRadius: BorderRadius.circular(10.r),
                      onTap: Scaffold.of(context).openDrawer,
                      child: Container(
                        alignment: Alignment.center,
                        width: 90.r,
                        height: 60.r,
                        child: Icon(
                          FlutterRemix.menu_line,
                          size: 20.r,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: Container(
                    height: 60.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.white,
                    ),
                    alignment: Alignment.center,
                    padding: REdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconTextButton(
                              backgroundColor: AppColors.greenMain.withOpacity(0.07),
                              iconData: FlutterRemix.user_fill,
                              iconColor: AppColors.greenMain,
                              title: AppHelpers.getTranslation("(03:40:33 2023/11/27)"),
                              textColor: AppColors.greenMain,
                              onPressed: () {},
                            ),
                            15.horizontalSpace,
                            CircleIconButton(
                              backgroundColor: AppColors.greenMain.withOpacity(0.07),
                              iconData: FlutterRemix.user_3_line,
                              iconColor: AppColors.greenMain,
                              onTap: () {},
                            ),
                            15.horizontalSpace,
                            CircleIconButton(
                              backgroundColor: AppColors.orderReviews.withOpacity(0.07),
                              iconData: FlutterRemix.scissors_2_line,
                              iconColor: AppColors.orderReviews,
                              onTap: () {},
                            ),
                            15.horizontalSpace,
                            CircleIconButton(
                              backgroundColor: AppColors.blue.withOpacity(0.07),
                              iconData: FlutterRemix.add_line,
                              iconColor: AppColors.blue,
                              onTap: () {},
                            ),
                            15.horizontalSpace,
                            CircleIconButton(
                              backgroundColor: AppColors.red.withOpacity(0.07),
                              iconData: FlutterRemix.close_line,
                              iconColor: AppColors.red,
                              onTap: () {},
                            ),
                            15.horizontalSpace,
                            CircleIconButton(
                              backgroundColor: AppColors.canceledOrders.withOpacity(0.07),
                              iconData: FlutterRemix.menu_2_line,
                              iconColor: AppColors.canceledOrders,
                              onTap: () {},
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconTextButton(
                              backgroundColor: AppColors.greenMain.withOpacity(0.07),
                              iconData: FlutterRemix.delete_bin_fill,
                              iconColor: AppColors.greenMain,
                              title: AppHelpers.getTranslation("In"),
                              textColor: AppColors.greenMain,
                              onPressed: () {},
                            ),
                            15.horizontalSpace,
                            IconTextButton(
                              backgroundColor: AppColors.greenMain.withOpacity(0.07),
                              iconData: FlutterRemix.delete_bin_fill,
                              iconColor: AppColors.greenMain,
                              title: AppHelpers.getTranslation("Mở ngăn kéo"),
                              textColor: AppColors.greenMain,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            Expanded(
              child: SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 790,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.r),
                                        color: AppColors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: screenWidth * 0.09,
                                              child: Text(
                                                stateBase.translate[stateBase.languageSelected]["product_name"],
                                                style: AppTypographies.styBlack11W400Opacity40,
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.1,
                                              child: Text(
                                                stateBase.translate[stateBase.languageSelected]["price"],
                                                style: AppTypographies.styBlack11W400Opacity40,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.1,
                                              child: Text(
                                                stateBase.translate[stateBase.languageSelected]["quantity"],
                                                style: AppTypographies.styBlack11W400Opacity40,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.1,
                                              child: Text(
                                                "%",
                                                style: AppTypographies.styBlack11W400Opacity40,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.1,
                                              child: Text(
                                                "${stateBase.translate[stateBase.languageSelected]["price"]} %",
                                                style: AppTypographies.styBlack11W400Opacity40,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.18,
                                              child: Text(
                                                stateBase.translate[stateBase.languageSelected]["money"],
                                                style: AppTypographies.styBlack11W400Opacity40,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 290,
                                      width: 790,
                                      child: MediaQuery.removePadding(
                                        context: context,
                                        removeTop: true,
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          physics: const CustomBouncingScrollPhysics(),
                                          itemCount: statePos.listTicket!.isNotEmpty ? statePos.listTicket![statePos.selectTicket!].ticketlines!.length : 0,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                notifierPos.updateIndex("ticketLine", index);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                                child: Container(
                                                  height: 30,
                                                  color: Colors.white,
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: screenWidth * 0.09,
                                                          child: Text(
                                                            "${notifierProducts.listProductCache.where((product) => product.id == statePos.listTicket![statePos.selectTicket!].ticketlines![index].productId).toList().first.name}",
                                                            style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: screenWidth * 0.1,
                                                          child: Text(
                                                            notifierPos.convertNumberZero(double.parse("${statePos.listTicket![statePos.selectTicket!].ticketlines![index].price}")),
                                                            style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                                            textAlign: TextAlign.right,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: screenWidth * 0.1,
                                                          child: Text(
                                                            notifierPos.convertNumberZero(statePos.listTicket![statePos.selectTicket!].ticketlines![index].unit!),
                                                            style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                                            textAlign: TextAlign.right,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                          child: Text(
                                                            (notifierProducts.taxCalculate(statePos.infoSelected![0][4], statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId!) * 100).toStringAsFixed(2),
                                                            style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                                            textAlign: TextAlign.right,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: screenWidth * 0.14,
                                                          child: Text(
                                                            notifierPos.convertNumberZero(
                                                                statePos.listTicket![statePos.selectTicket!].ticketlines![index].price! * (1 + notifierProducts.taxCalculate(statePos.infoSelected![0][4], statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId!) / 100)),
                                                            style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                                            textAlign: TextAlign.right,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: screenWidth * 0.18,
                                                          child: Text(
                                                            notifierPos.convertNumberZero(statePos.listTicket![statePos.selectTicket!].ticketlines![index].price! *
                                                                (1 + notifierProducts.taxCalculate(statePos.infoSelected![0][4], statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId!) / 100) *
                                                                double.parse("${statePos.listTicket![statePos.selectTicket!].ticketlines![index].unit}")),
                                                            style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                                            textAlign: TextAlign.right,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              10.horizontalSpace,
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: AppColors.white,
                                    ),
                                    height: 330,
                                    width: 60),
                              )
                            ],
                          )),
                          10.verticalSpace,
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: AppColors.white,
                                ),
                                alignment: Alignment.center,
                                height: 60.r,
                                padding: REdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                child: const Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Chiết khấu: "),
                                          Expanded(child: TextField()),
                                          VerticalDivider(),
                                          // 10.horizontalSpace,
                                          Text("Tổng: "),
                                          Expanded(child: TextField()),
                                          VerticalDivider(),
                                          // 10.horizontalSpace,
                                          Text("Tổng số: "),
                                          Expanded(child: TextField()),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    10.horizontalSpace,
                    SizedBox(
                        width: 300.r,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            6.verticalSpace,
                            Expanded(
                                child: Container(
                              height: 390,
                              padding: REdgeInsets.symmetric(horizontal: 12, vertical: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.white,
                              ),
                            ))
                          ],
                        )),
                  ],
                ),
              ),
            ),
            10.verticalSpace,
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                  child: SizedBox(
                    width: 290,
                    height: 300,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const CustomBouncingScrollPhysics(),
                        itemCount: stateCategories.categories!.length,
                        shrinkWrap: false,
                        itemBuilder: (context, index) {
                          return CategoryPosItem(
                            title: '${stateCategories.categories![index].name}',
                            isSelected: statePos.selectCategory == index ? true : false,
                            onTap: () {
                              setState(() {
                                notifierPos.updateIndex("category", index);
                                notifierProducts.getProductByCategory(stateCategories.categories![index].id);
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                10.horizontalSpace,
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                  child: SizedBox(
                    width: screenWidth * 0.72,
                    height: 300,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView(
                        physics: const CustomBouncingScrollPhysics(),
                        children: [
                          stateProducts.products!.isNotEmpty
                              ? GridView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: stateProducts.products!.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 2.7,
                                    crossAxisCount: 4,
                                  ),
                                  itemBuilder: (context, index) {
                                    final product = stateProducts.products![index];
                                    return GestureDetector(
                                      onLongPress: () {
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) {
                                            return ProductShortInfoModal(product: product);
                                          },
                                        );
                                      },
                                      onTap: () {
                                        if ((reasonSelected == 2) || (reasonSelected == -1)) {
                                          notifierPos.addTicketline(product, statePos.selectTicket);
                                          notifierPos.updateIndex("ticketLine", statePos.listTicket![statePos.selectTicket!].ticketlines!.length - 1);
                                        }
                                        notifierProducts.taxCalculate(stateCustomer.customerSelected != null ? statePos.infoSelected![0][4] : "", product.taxCat!);
                                      },
                                      child: ProductItemPOS(
                                        selectWarehouseId: notifierBase.checkShareMode() ? stateBase.baseInfomation["warehouse_id"] : stateProducts.warehouseSelected["id"],
                                        product: product,
                                      ),
                                    );
                                  },
                                )
                              : Text(
                                  stateBase.translate[stateBase.languageSelected]["product_not_found"],
                                  textAlign: TextAlign.center,
                                )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }
}
