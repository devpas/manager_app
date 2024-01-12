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
import 'package:intl/intl.dart';
import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/routes/app_router.gr.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../components/components.dart';
import '../../pages/customers/widgets/w_delete_customer_dialog.dart';
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

  int indexItemSelected = 0;

  bool activeCheckBox = true;
  XFile? image;
  TextEditingController codeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dtgtController = TextEditingController();
  TextEditingController maxdebtController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String taxCusCategoryIdSelected = "";
  String createdate = "";
  String card = "";
  String currentDebt = "";
  String curDate = "";
  String nowDate = "";
  var taxCusCategories = [];

  bool createMode = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 4, vsync: this);
    Future.delayed(
      Duration.zero,
      () {
        ref.read(customersProvider.notifier).fetchListCustomers();
        loadValue();
      },
    );
  }

  Widget notes() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: screenWidth * 0.67,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.3),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: noteController,
                    maxLines: 7,
                    decoration: const InputDecoration.collapsed(hintText: ''),
                  ),
                ),
              ),
              //create Text content "AAAA"
            ],
          ),
        ),
      ],
    );
  }

  Widget contact() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: screenWidth * 0.67,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(width: screenWidth * 0.1, child: Text("Mã kho:")),
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
            ],
          ),
        ),
      ],
    );
  }

  Widget address() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: screenWidth * 0.67,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(width: screenWidth * 0.1, child: Text("Mã kho:")),
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
            ],
          ),
        ),
      ],
    );
  }

  void loadValue() async {
    setState(() {
      final taxCusCategoriess = ref.watch(productsPASProvider).taxCusCategories!;
      for (int i = 0; i < taxCusCategoriess.length; i++) {
        taxCusCategories.add(taxCusCategoriess[i]);
      }
      taxCusCategories.insert(0, {"index": -1, "id": "", "name": ""});
    });
  }

  void newCustomer() {
    final stateProduct = ref.watch(productsPASProvider);
    setState(() {
      createMode = true;
      activeCheckBox = false;
      codeController.text = "";
      phoneController.text = "";
      nameController.text = "";
      dtgtController.text = "";
      maxdebtController.text = "0";
      noteController.text = "0";
      createdate = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
      card = "";
      currentDebt = "0";
      taxCusCategoryIdSelected = stateProduct.taxCusCategories![0]["id"];
      curDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    });
  }

  void loadDataCustomer() {
    final state = ref.watch(customersProvider);
    CustomerData customer = state.customerSelected!;
    print(customer.id);
    setState(() {
      createMode = false;
      activeCheckBox = customer.visible == 1 ? true : false;
      codeController.text = customer.searchkey!;
      phoneController.text = customer.phone!;
      nameController.text = customer.name!;
      dtgtController.text = customer.ngt ?? "";
      maxdebtController.text = customer.maxDebt.toString();
      noteController.text = customer.note!;
      createdate = customer.createDate.toString();
      card = customer.card!;
      currentDebt = customer.curDebt.toString();
      taxCusCategoryIdSelected = customer.taxCusCategory!;
      curDate = customer.curdate.toString();
    });
  }

  void saveCustomer() {
    final notifier = ref.read(customersProvider.notifier);
    final state = ref.watch(customersProvider);
    CustomerData customer = CustomerData().initCustomer();
    if (createMode == false) {
      customer = state.customerSelected!;
    }
    customer = customer.copyWith(
        name: nameController.text,
        searchkey: "'${codeController.text}",
        phone: "'${phoneController.text}",
        ngt: "'${dtgtController.text}",
        maxDebt: double.parse(maxdebtController.text),
        note: "'${noteController.text}",
        createDate: DateTime.parse(createdate),
        card: "'$card",
        curDebt: double.parse(currentDebt),
        taxCusCategory: taxCusCategoryIdSelected,
        curdate: DateTime.parse(curDate),
        visible: activeCheckBox ? 1 : 0);
    // print(state.productSelected!.index);
    var customerData = customer.toJson();
    if (createMode) {
      notifier.addCustomer(customerData);
    } else {
      notifier.updateCustomer(customerData);
    }
    setState(() {
      indexItemSelected = 0;
    });
    notifier.resetSearch();
    notifier.selectCustomer(state.customers![0].id!);
    loadDataCustomer();
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
    final stateProduct = ref.watch(productsPASProvider);
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
                    SizedBox(width: screenWidth * 0.28, child: Text("0/${state.customers!.length}")),
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
                            newCustomer();
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
                                return WDeleteCustomerDialog(
                                  alias: state.customerSelected!.id!,
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
                            saveCustomer();
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
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      indexItemSelected = index;
                                    });
                                    notifier.selectCustomer(customer.id!);
                                    loadDataCustomer();
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
                                                  customer.name!,
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
                        height: screenHeight * 0.5,
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
                                  SizedBox(width: screenWidth * 0.1, child: const Text("Mã số:")),
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
                                  10.horizontalSpace,
                                  Row(
                                    children: [
                                      Text(
                                        "Thấy được",
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
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  SizedBox(width: screenWidth * 0.1, child: const Text("SĐT:")),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SizedBox(
                                      width: screenWidth * 0.185,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: phoneController,
                                            decoration: const InputDecoration.collapsed(
                                              hintText: '',
                                            ),
                                          ),
                                          const Divider(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  SizedBox(width: screenWidth * 0.1, child: const Text("Ngày tạo:")),
                                  SizedBox(width: screenWidth * 0.185, child: Text(createdate)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  SizedBox(width: screenWidth * 0.1, child: const Text("Tên:")),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SizedBox(
                                      width: screenWidth * 0.475,
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
                                  5.horizontalSpace,
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  SizedBox(width: screenWidth * 0.1, child: const Text("Card:")),
                                  AbsorbPointer(
                                    absorbing: true,
                                    child: SizedBox(width: screenWidth * 0.185, child: Text(card)),
                                  ),
                                  20.horizontalSpace,
                                  CircleIconButton(
                                    backgroundColor: AppColors.canceledOrders.withOpacity(0.07),
                                    iconData: FlutterRemix.edit_2_line,
                                    iconColor: AppColors.canceledOrders,
                                    onTap: () {},
                                  ),
                                  20.horizontalSpace,
                                  CircleIconButton(
                                    backgroundColor: AppColors.canceledOrders.withOpacity(0.07),
                                    iconData: FlutterRemix.close_line,
                                    iconColor: AppColors.canceledOrders,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  SizedBox(width: screenWidth * 0.1, child: const Text("Người giới thiệu:")),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SizedBox(
                                      width: screenWidth * 0.19,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: dtgtController,
                                            decoration: const InputDecoration.collapsed(
                                              hintText: '',
                                            ),
                                          ),
                                          const Divider(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  20.horizontalSpace,
                                  AbsorbPointer(
                                    absorbing: true,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: SizedBox(
                                        width: screenWidth * 0.19,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              initialValue: "",
                                              decoration: const InputDecoration.collapsed(
                                                hintText: '',
                                              ),
                                            ),
                                            const Divider(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  SizedBox(width: screenWidth * 0.1, child: const Text("Nhóm KH:")),
                                  SizedBox(
                                    width: screenWidth * 0.185,
                                    child: Column(
                                      children: [
                                        taxCusCategories.isNotEmpty
                                            ? DropdownButton(
                                                value: taxCusCategoryIdSelected == "" ? taxCusCategories[0] : taxCusCategories.where((e) => e["id"] == taxCusCategoryIdSelected).first,
                                                items: taxCusCategories.map<DropdownMenuItem<dynamic>>((dynamic value) {
                                                  return DropdownMenuItem<dynamic>(
                                                    value: value,
                                                    child: SizedBox(width: screenWidth * 0.160, child: Text(value["name"])),
                                                  );
                                                }).toList(),
                                                onChanged: (e) {
                                                  setState(() {
                                                    taxCusCategoryIdSelected = e["id"];
                                                  });
                                                })
                                            : Text("Chưa có mục chiết khấu"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  SizedBox(width: screenWidth * 0.1, child: const Text("Cho nợ-Nợ-Ngày nợ:")),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SizedBox(
                                      width: screenWidth * 0.185,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: maxdebtController,
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
                                  AbsorbPointer(
                                    absorbing: true,
                                    child: SizedBox(width: screenWidth * 0.185, child: Text(currentDebt)),
                                  ),
                                  5.horizontalSpace,
                                  AbsorbPointer(
                                    absorbing: true,
                                    child: SizedBox(width: screenWidth * 0.185, child: Text(curDate)),
                                  ),
                                  5.horizontalSpace,
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  SizedBox(width: screenWidth * 0.1, child: const Text("ĐH cuối-CG cuối:")),
                                  AbsorbPointer(
                                    absorbing: true,
                                    child: SizedBox(width: screenWidth * 0.185, child: Text(curDate)),
                                  ),
                                  5.horizontalSpace,
                                  AbsorbPointer(
                                    absorbing: true,
                                    child: SizedBox(width: screenWidth * 0.185, child: Text(nowDate)),
                                  ),
                                  20.horizontalSpace,
                                  CircleIconButton(
                                    backgroundColor: AppColors.canceledOrders.withOpacity(0.07),
                                    iconData: FlutterRemix.calendar_check_line,
                                    iconColor: AppColors.canceledOrders,
                                    onTap: () {
                                      setState(() {
                                        nowDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                      10.verticalSpace,
                      Container(
                        height: screenHeight * 0.315,
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
                                        children: [notes(), notes(), contact(), address()],
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
