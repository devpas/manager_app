import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/data/customer_data.dart';
import 'package:g_manager_app/modify/models/data/product_data.dart';
import 'package:g_manager_app/modify/presentation/pages/pos/pos_manage/products_manage/products/widgets/product_item_pas.dart';
import 'package:g_manager_app/modify/presentation/pages_dekstop/widgets/drawer_tablet.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/routes/app_router.gr.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../components/components.dart';
import '../../theme/theme.dart';

class OrdersDesktopPage extends ConsumerStatefulWidget {
  const OrdersDesktopPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OrdersDesktopPage> createState() => _OrdersDesktopPageState();
}

class _OrdersDesktopPageState extends ConsumerState<OrdersDesktopPage> with TickerProviderStateMixin {
  late ScrollController _scrollController;

  TextEditingController searchController = TextEditingController();
  late TabController _tabController;
  bool activeCheckBox = true;

  String inputText = "";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 4, vsync: this);
    Future.delayed(
      Duration.zero,
      () {},
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Widget calculatorAccount(BuildContext context) {
    final statePos = ref.watch(posSystemPASProvider);
    final notifierPos = ref.read(posSystemPASProvider.notifier);
    return Container(
      width: 185,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText = "";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 130.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "CE",
                          style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "-",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "7";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "7",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "8";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "8",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "9";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "9",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "4";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "4",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "5";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "5",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "6";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "6",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "1";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "1",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "2";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "2",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "3";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "3",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "0";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 130.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "0",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    inputText += ".";
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          ".",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                      width: 130.r,
                      height: 60.r,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(5.r),
                        color: Colors.green.withOpacity(0.1),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(inputText)],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                      width: 60.r,
                      height: 60.r,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(5.r),
                        color: Colors.green.withOpacity(0.1),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        FlutterRemix.check_line,
                        size: 20.r,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customersProvider);
    final stateBase = ref.watch(baseProvider);
    final notifier = ref.read(customersProvider.notifier);
    final notifierBase = ref.read(baseProvider.notifier);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        backgroundColor: AppColors.mainBackground,
        drawer: const WMainDrawerPosDesktop(),
        appBar: CustomAppbarPOS(
          title: Text(
            stateBase.translate[stateBase.languageSelected]["order"],
            style: AppTypographies.styBlack16W500,
            textAlign: TextAlign.center,
          ),
          leading: Builder(
            builder: (context) => SmallIconButton(
              icon: Icon(
                FlutterRemix.menu_line,
                size: 24.r,
                color: AppColors.black,
              ),
              onPressed: Scaffold.of(context).openDrawer,
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
                    Container(
                        width: screenWidth * 0.15,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.inProgressOrders.withOpacity(0.1),
                        ),
                        alignment: Alignment.centerLeft,
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                          child: Row(
                            children: [Text("")],
                          ),
                        )),
                    SizedBox(
                      child: Row(children: [
                        30.horizontalSpace,
                        IconTextButton(
                          backgroundColor: AppColors.blue.withOpacity(0.07),
                          iconData: FlutterRemix.delete_bin_fill,
                          iconColor: AppColors.blue,
                          title: "Tìm kiếm",
                          textColor: AppColors.blue,
                          onPressed: () {
                            // notifierBase.loadTranslate();
                          },
                        ),
                        20.horizontalSpace,
                        IconTextButton(
                          backgroundColor: AppColors.blue.withOpacity(0.07),
                          iconData: FlutterRemix.delete_bin_fill,
                          iconColor: AppColors.blue,
                          title: "Chỉnh sửa",
                          textColor: AppColors.blue,
                          onPressed: () {
                            // notifierBase.loadTranslate();
                          },
                        ),
                        20.horizontalSpace,
                        IconTextButton(
                          backgroundColor: AppColors.blue.withOpacity(0.07),
                          iconData: FlutterRemix.delete_bin_fill,
                          iconColor: AppColors.blue,
                          title: "Trả lại",
                          textColor: AppColors.blue,
                          onPressed: () {
                            // notifierBase.loadTranslate();
                          },
                        ),
                        20.horizontalSpace,
                        IconTextButton(
                          backgroundColor: AppColors.blue.withOpacity(0.07),
                          iconData: FlutterRemix.delete_bin_fill,
                          iconColor: AppColors.blue,
                          title: "In",
                          textColor: AppColors.blue,
                          onPressed: () {
                            // notifierBase.loadTranslate();
                          },
                        ),
                      ]),
                    ),
                  ]),
                ),
              ),
            ),
            //write widget container white , height 500, with 300
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    height: screenHeight * 0.83,
                    width: screenWidth * 0.735,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    height: screenHeight * 0.83,
                    width: screenWidth * 0.25,
                    child: Column(children: [
                      calculatorAccount(context),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bán hàng",
                              style: GoogleFonts.inter(
                                color: activeCheckBox ? AppColors.black : AppColors.black.withOpacity(0.5),
                              ),
                            ),
                            RoundedCheckBox(
                              value: activeCheckBox,
                              onChanged: (value) {
                                setState(() {
                                  activeCheckBox = !activeCheckBox;
                                });
                              },
                            ),
                            10.horizontalSpace,
                            Text(
                              "Thu phí",
                              style: GoogleFonts.inter(
                                color: activeCheckBox ? AppColors.black : AppColors.black.withOpacity(0.5),
                              ),
                            ),
                            RoundedCheckBox(
                              value: !activeCheckBox,
                              onChanged: (value) {
                                setState(() {
                                  activeCheckBox = !activeCheckBox;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
