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
import '../widgets/calculator_simple.dart';

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
                      CalculatorSimple(
                        onPayment: () {},
                      ),
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
