import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/data/customer_data.dart';
import 'package:g_manager_app/modify/models/data/product_data.dart';
import 'package:g_manager_app/modify/presentation/pages_dekstop/widgets/drawer_tablet.dart';
import 'package:g_manager_app/modify/presentation/pages_dekstop/widgets/transfer_money_account_modal.dart';
import 'package:g_manager_app/modify/riverpob/notifiers/notifiers.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:g_manager_app/modify/riverpob/states/products/products_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../components/components.dart';

import '../../../theme/theme.dart';
import '../../widgets/pay_info_modal_pas.dart';

class AccountPosDesktopPage extends ConsumerStatefulWidget {
  const AccountPosDesktopPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountPosDesktopPage> createState() => _AccountPosDesktopPageState();
}

class _AccountPosDesktopPageState extends ConsumerState<AccountPosDesktopPage> with TickerProviderStateMixin {
  late ScrollController _scrollController;

  TextEditingController searchController = TextEditingController();

  int indexItemSelected = 0;

  final ItemScrollController _scrollControllerItem = ItemScrollController();

  // search text

  TextEditingController codeSearchController = TextEditingController();
  TextEditingController nameSearchController = TextEditingController();
  TextEditingController phoneSearchController = TextEditingController();
  List<String> conditionCompare = ["None", "Equals", "Wildcards", "Distinct", "Greater", "Greate or equal", "Less or equals"];

  // infomation text

  TextEditingController noteController = TextEditingController();

  String categoryName = "";
  TextEditingController attributeController = TextEditingController();

  bool findStatus = true;

  String inputText = "";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(customersProvider.notifier).fetchListCustomers();
        noteController.text = ref.watch(customersProvider).customerSelected!.note!;
      },
    );
  }

  Widget calculatorOrders(BuildContext context) {
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

  XFile? image;

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    print(state.customers!.isEmpty);
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        backgroundColor: AppColors.mainBackground,
        drawer: const WMainDrawerPosDesktop(),
        appBar: CustomAppbarPOS(
          title: Text(
            stateBase.translate[stateBase.languageSelected]["product"],
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
        body: state.customers!.isNotEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  5.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      height: screenHeight * 0.11,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            height: screenHeight * 0.1,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.2,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                const Text("Tìm tài khoản"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: screenWidth * 0.05, child: const Text("Mã số:")),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: SizedBox(
                                              width: screenWidth * 0.2,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: codeSearchController,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        codeSearchController.text = value;
                                                      });
                                                    },
                                                    decoration: const InputDecoration.collapsed(
                                                      hintText: '',
                                                    ),
                                                  ),
                                                  const Divider(),
                                                ],
                                              ),
                                            ),
                                          ),
                                          5.verticalSpace,
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: screenWidth * 0.05, child: const Text("Số ĐT:")),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: SizedBox(
                                              width: screenWidth * 0.2,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: phoneSearchController,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        phoneSearchController.text = value;
                                                      });
                                                    },
                                                    decoration: const InputDecoration.collapsed(
                                                      hintText: '',
                                                    ),
                                                  ),
                                                  const Divider(),
                                                ],
                                              ),
                                            ),
                                          ),
                                          5.verticalSpace,
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: screenWidth * 0.05, child: const Text("Tên:")),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: SizedBox(
                                              width: screenWidth * 0.2,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: nameSearchController,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        nameSearchController.text = value;
                                                      });
                                                    },
                                                    decoration: const InputDecoration.collapsed(
                                                      hintText: '',
                                                    ),
                                                  ),
                                                  const Divider(),
                                                ],
                                              ),
                                            ),
                                          ),
                                          5.verticalSpace,
                                          20.horizontalSpace
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
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
                          SizedBox(width: screenWidth * 0.235, child: Text("$indexItemSelected/${state.customersAfterFilter!.isNotEmpty ? state.customersAfterFilter!.length : state.customers!.length}")),
                          SizedBox(
                            child: Row(children: [
                              CircleIconButton(
                                backgroundColor: AppColors.blue.withOpacity(0.07),
                                iconData: FlutterRemix.search_line,
                                iconColor: AppColors.blue,
                                onTap: () {
                                  var searchParam = [codeSearchController.text.toLowerCase(), phoneSearchController.text.toLowerCase(), nameSearchController.text.toLowerCase()];
                                  notifier.searchCustomersMultiConditions(searchParam);
                                },
                              ),
                              15.horizontalSpace,
                              CircleIconButton(
                                backgroundColor: AppColors.canceledOrders.withOpacity(0.07),
                                iconData: FlutterRemix.save_line,
                                iconColor: AppColors.canceledOrders,
                                onTap: () {
                                  var customer = state.customerSelected;
                                  customer = customer!.copyWith(note: noteController.text);
                                  notifier.updateCustomer(customer.toJson());
                                },
                              ),
                              15.horizontalSpace,
                              IconTextButton(
                                backgroundColor: AppColors.greenMain.withOpacity(0.07),
                                iconData: stateBase.sendMoneyLoading! ? FlutterRemix.loader_3_fill : FlutterRemix.exchange_dollar_line,
                                iconColor: AppColors.greenMain,
                                title: "Thanh toán tài khoản",
                                textColor: AppColors.greenMain,
                                onPressed: () {
                                  if (stateBase.sendMoneyLoading! == false) {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return const TransferMoneyAccountModal();
                                      },
                                    );
                                  }
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
                          width: screenWidth * 0.25,
                          height: screenHeight * 0.72,
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
                                  child: ScrollablePositionedList.builder(
                                    itemScrollController: _scrollControllerItem,
                                    itemCount: state.customersAfterFilter!.isEmpty && findStatus == true ? state.customers!.length : state.customersAfterFilter!.length,
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
                                            notifier.selectCustomer(customer.id!);
                                            noteController.text = customer.note!;
                                          });
                                        },
                                        child: Container(
                                          width: 500,
                                          color: index == indexItemSelected ? Colors.blue : Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  customer.name!,
                                                  style: TextStyle(color: index == indexItemSelected ? Colors.white : Colors.black),
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
                        Container(
                          width: screenWidth * 0.735,
                          height: screenHeight * 0.72,
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
                                      Text(state.customerSelected!.name!),
                                      20.verticalSpace,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.55,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8),
                                                      child: SizedBox(width: screenWidth * 0.1, child: const Text("Mã số:")),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8),
                                                      child: SizedBox(child: Text("${state.customerSelected!.searchkey}")),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8),
                                                      child: SizedBox(width: screenWidth * 0.1, child: const Text("SĐT:")),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8),
                                                      child: SizedBox(child: Text("${state.customerSelected!.phone}")),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8),
                                                      child: SizedBox(width: screenWidth * 0.1, child: const Text("Tên:")),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8),
                                                      child: SizedBox(child: Text("${state.customerSelected!.name}")),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8),
                                                      child: SizedBox(width: screenWidth * 0.1, child: const Text("Card:")),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8),
                                                      child: SizedBox(child: Text("${state.customerSelected!.card}")),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8),
                                                      child: SizedBox(width: screenWidth * 0.1, child: const Text("Ghi chú:")),
                                                    ),
                                                    SizedBox(
                                                      width: screenWidth * 0.45,
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                              controller: noteController,
                                                              maxLines: 5,
                                                              decoration: const InputDecoration(
                                                                border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
                                                                hintText: '',
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                5.verticalSpace,
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8),
                                                      child: SizedBox(width: screenWidth * 0.1, child: const Text("Nợ tối đa:")),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8),
                                                      child: SizedBox(child: Text("${state.customerSelected!.maxDebt}")),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8),
                                                      child: SizedBox(width: screenWidth * 0.1, child: const Text("Nợ hiện tại:")),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8),
                                                      child: SizedBox(child: Text("${state.customerSelected!.curDebt}")),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8),
                                                      child: SizedBox(width: screenWidth * 0.1, child: const Text("TT cuối:")),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8),
                                                      child: SizedBox(child: Text("${state.customerSelected!.createDate}")),
                                                    ),
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
                                                children: [calculatorOrders(context)],
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : Center(
                child: Text("Chưa có khách hàng"),
              ),
      ),
    );
  }
}
