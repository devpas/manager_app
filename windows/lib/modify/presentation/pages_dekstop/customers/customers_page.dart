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
import 'package:image_picker/image_picker.dart';
import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/routes/app_router.gr.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../components/components.dart';
import '../../theme/theme.dart';

class CustomersDesktopPage extends ConsumerStatefulWidget {
  const CustomersDesktopPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomersDesktopPage> createState() => _CustomersDesktopPageState();
}

class _CustomersDesktopPageState extends ConsumerState<CustomersDesktopPage> with TickerProviderStateMixin {
  late ScrollController _scrollController;

  TextEditingController searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 4, vsync: this);
    Future.delayed(
      Duration.zero,
      () {
        ref.read(customersProvider.notifier).fetchListCustomers();
        if (ref.watch(categoriesPASProvider).categorySelected == null) {
          ref.read(categoriesPASProvider.notifier).setCategorySelected(ref.watch(categoriesPASProvider).categories![0]);
        }
      },
    );
  }

  TextEditingController codeController = TextEditingController();

  XFile? image;

  Widget summary() {
    final state = ref.watch(customersProvider);
    final stateBase = ref.watch(baseProvider);
    final notifier = ref.read(customersProvider.notifier);
    final notifierBase = ref.read(baseProvider.notifier);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: screenWidth * 0.43,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(width: screenWidth * 0.1, child: Text("Mã kho:")),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      SizedBox(
                        child: TextFormField(
                          controller: codeController,
                          decoration: const InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  )),
                  5.verticalSpace,
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(width: screenWidth * 0.1, child: const Text("Giá mua:")),
                  ),
                  SizedBox(
                    width: screenWidth * 0.185,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: codeController,
                          decoration: const InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                  5.verticalSpace,
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(width: screenWidth * 0.1, child: const Text("Giá bán:")),
                  ),
                  SizedBox(
                    width: screenWidth * 0.185,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: codeController,
                          decoration: const InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                  5.verticalSpace,
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(width: screenWidth * 0.1, child: const Text("Giá sau CK:")),
                  ),
                  SizedBox(
                    width: screenWidth * 0.185,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: codeController,
                          decoration: const InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                  5.verticalSpace,
                ],
              ),
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.1, child: const Text("Loại chiết khấu:")),
                  SizedBox(
                    width: screenWidth * 0.185,
                    child: Column(
                      children: [
                        DropdownButton(
                            items: ["A", "B", "C"].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: SizedBox(width: screenWidth * 0.160, child: Text(value)),
                              );
                            }).toList(),
                            onChanged: (e) {}),
                      ],
                    ),
                  ),
                  5.verticalSpace,
                ],
              ),
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.1, child: const Text("Cấp trên:")),
                  SizedBox(
                    width: screenWidth * 0.185,
                    child: Column(
                      children: [
                        DropdownButton(
                            items: ["A", "B", "C"].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: SizedBox(width: screenWidth * 0.160, child: Text(value)),
                              );
                            }).toList(),
                            onChanged: (e) {}),
                      ],
                    ),
                  ),
                  5.verticalSpace,
                ],
              ),
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.1, child: const Text("Thuộc tính:")),
                  SizedBox(
                    width: screenWidth * 0.185,
                    child: Column(
                      children: [
                        DropdownButton(
                            items: ["A", "B", "C"].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: SizedBox(width: screenWidth * 0.160, child: Text(value)),
                              );
                            }).toList(),
                            onChanged: (e) {}),
                      ],
                    ),
                  ),
                  5.verticalSpace,
                ],
              ),
            ],
          ),
        ),
        8.horizontalSpace,
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SelectImageCustomeSize(
                    file: image,
                    heigth: screenHeight * 0.35,
                    width: screenWidth * 0.2,
                    onChangePhoto: (XFile file) {
                      setState(() {
                        image = file;
                      });
                    },
                  ),
                ),
                10.horizontalSpace,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleIconButton(
                      backgroundColor: AppColors.blue.withOpacity(0.1),
                      iconData: FlutterRemix.folder_2_line,
                      iconColor: AppColors.blue,
                      onTap: () {},
                    ),
                    10.verticalSpace,
                    CircleIconButton(
                      backgroundColor: AppColors.blue.withOpacity(0.1),
                      iconData: FlutterRemix.close_line,
                      iconColor: AppColors.blue,
                      onTap: () {},
                    ),
                    10.verticalSpace,
                    CircleIconButton(
                      backgroundColor: AppColors.blue.withOpacity(0.1),
                      iconData: FlutterRemix.file_search_line,
                      iconColor: AppColors.blue,
                      onTap: () {},
                    ),
                    10.verticalSpace,
                    CircleIconButton(
                      backgroundColor: AppColors.blue.withOpacity(0.1),
                      iconData: FlutterRemix.zoom_in_line,
                      iconColor: AppColors.blue,
                      onTap: () {},
                    ),
                    10.verticalSpace,
                    CircleIconButton(
                      backgroundColor: AppColors.blue.withOpacity(0.1),
                      iconData: FlutterRemix.zoom_out_line,
                      iconColor: AppColors.blue,
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ],
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
            stateBase.translate[stateBase.languageSelected]["customer"],
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
                    SizedBox(width: screenWidth * 0.235, child: Text("0/${state.customers!.length}")),
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
                          onTap: () {},
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
                          onTap: () {},
                        ),
                        20.horizontalSpace,
                        CircleIconButton(
                          backgroundColor: AppColors.red.withOpacity(0.07),
                          iconData: FlutterRemix.close_line,
                          iconColor: AppColors.red,
                          onTap: () {},
                        ),
                        25.horizontalSpace,
                        CircleIconButton(
                          backgroundColor: AppColors.blue.withOpacity(0.07),
                          iconData: FlutterRemix.save_line,
                          iconColor: AppColors.blue,
                          onTap: () {},
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
                    child: state.customerLoading!
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
                              itemCount: state.customersAfterFilter!.isEmpty ? state.customers!.length : state.customersAfterFilter!.length,
                              itemBuilder: (context, index) {
                                CustomerData customer;
                                if (state.customersAfterFilter!.isEmpty) {
                                  customer = state.customers![index];
                                } else {
                                  customer = state.customersAfterFilter![index];
                                }
                                return GestureDetector(
                                  onTap: () {
                                    notifier.selectCustomer(customer.id!);
                                  },
                                  child: Container(
                                    color: customer.id == state.customerSelected!.id ? Colors.blue : Colors.white,
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
                                                  customer.name!,
                                                  style: TextStyle(color: customer.id == state.customerSelected!.id ? Colors.white : Colors.black),
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
                        height: screenHeight * 0.285,
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
                            const Text("Theo hình thức"),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  SizedBox(width: screenWidth * 0.1, child: const Text("Tên:")),
                                  SizedBox(
                                    width: screenWidth * 0.185,
                                    child: Column(
                                      children: [
                                        DropdownButton(
                                            items: ["A", "B", "C"].map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: SizedBox(width: screenWidth * 0.160, child: Text(value)),
                                              );
                                            }).toList(),
                                            onChanged: (e) {}),
                                      ],
                                    ),
                                  ),
                                  5.horizontalSpace,
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SizedBox(
                                      width: screenWidth * 0.185,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: codeController,
                                            decoration: const InputDecoration.collapsed(
                                              hintText: '',
                                            ),
                                          ),
                                          const Divider(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  5.horizontalSpace,
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  SizedBox(width: screenWidth * 0.1, child: const Text("Giá mua:")),
                                  SizedBox(
                                    width: screenWidth * 0.185,
                                    child: Column(
                                      children: [
                                        DropdownButton(
                                            items: ["A", "B", "C"].map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: SizedBox(width: screenWidth * 0.160, child: Text(value)),
                                              );
                                            }).toList(),
                                            onChanged: (e) {}),
                                      ],
                                    ),
                                  ),
                                  5.horizontalSpace,
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SizedBox(
                                      width: screenWidth * 0.185,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: codeController,
                                            decoration: const InputDecoration.collapsed(
                                              hintText: '',
                                            ),
                                          ),
                                          const Divider(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  5.horizontalSpace,
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                      5.verticalSpace,
                      Container(
                        height: screenHeight * 0.53,
                        width: screenWidth * 0.685,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: state.customerLoading!
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.greenMain,
                                  strokeWidth: 2,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text("${state.customers!.nam!}-${state.productSelected!.name!}"),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: SizedBox(width: screenWidth * 0.05, child: const Text("Mã kho:")),
                                        ),
                                        Expanded(
                                            child: SizedBox(
                                          child: TextFormField(
                                            controller: codeController,
                                            decoration: const InputDecoration.collapsed(hintText: ''),
                                          ),
                                        ))
                                      ],
                                    ),
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
                                          Tab(text: stateBase.translate[stateBase.languageSelected]["notes"]),
                                          Tab(text: stateBase.translate[stateBase.languageSelected]["transaction"]),
                                          Tab(text: stateBase.translate[stateBase.languageSelected]["contact"]),
                                          Tab(text: stateBase.translate[stateBase.languageSelected]["address"]),
                                        ],
                                      ),
                                    ),
                                    18.verticalSpace,
                                    Expanded(
                                      child: TabBarView(
                                        controller: _tabController,
                                        physics: const CustomBouncingScrollPhysics(),
                                        children: [summary(), summary(), summary(), summary()],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
