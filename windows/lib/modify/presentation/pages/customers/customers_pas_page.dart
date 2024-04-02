import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/src/core/utils/local_storage.dart';

import '../../../../src/core/routes/app_router.gr.dart';
import '../../../../modify/presentation/components/components.dart';
import '../../../../modify/presentation/theme/theme.dart';
import '../../../riverpob/notifiers/notifiers.dart';
import '../../../riverpob/providers/providers.dart';
import '../../../riverpob/states/customers/customers_state.dart';
import 'widgets/customer_item.dart';
import 'widgets/shop_item.dart';
import 'widgets/w_delete_customer_dialog.dart';

class CustomersPasPage extends ConsumerStatefulWidget {
  const CustomersPasPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomersPasPage> createState() => _CustomersPasPageState();
}

class _CustomersPasPageState extends ConsumerState<CustomersPasPage> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  TextEditingController searchController = TextEditingController();

  bool searching = false;

  List<String> searchType = ["Mã số", "SĐT", "Tên", "Ghi chú", "TT cuối"];

  int searchTypeSelected = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.delayed(
      Duration.zero,
      () {
        ref.read(productsPASProvider.notifier).getListCustomerType();
        ref.read(customersProvider.notifier).fetchListCustomers();
        ref.read(customersProvider.notifier).fetchListShops();
      },
    );
    _scrollController = ScrollController();
    // _scrollController.addListener(
    //   () {
    //     if (_scrollController.position.maxScrollExtent ==
    //         _scrollController.position.pixels) {
    //       ref.read(categoriesPASProvider.notifier).fetchCategoriesAppscript();
    //     }
    //   },
    // );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Widget tabCustomer(CustomersState state, CustomersNotifier notifier) {
    final notifierBase = ref.read(baseProvider.notifier);
    return state.customerLoading!
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.greenMain,
              strokeWidth: 3.r,
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SearchTextField(
                textEditingController: searchController,
                onChanged: (e) {
                  if (e.length >= 3) {
                    setState(() {
                      searching = true;
                    });
                    print(searchTypeSelected);
                    notifier.searchCustomer(e, searchTypeSelected);
                  } else {
                    setState(() {
                      searching = false;
                    });
                    notifier.resetSearch();
                  }
                },
                hintText: "Tìm khách hàng",
                suffixIcon: SmallIconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Material(
                        color: AppColors.white,
                        child: Padding(
                          padding: REdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              24.verticalSpace,
                              Text(
                                "Chọn kiểu tìm kiếm",
                                style: AppTypographies.styBlack22W500,
                              ),
                              24.verticalSpace,
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const CustomBouncingScrollPhysics(),
                                itemCount: searchType.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Container(
                                      height: 20.r,
                                      width: 20.r,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.r),
                                        color: searchTypeSelected == index ? AppColors.white : AppColors.transparent,
                                        border: Border.all(
                                          color: searchTypeSelected == index ? AppColors.greenMain : AppColors.productBorder,
                                          width: searchTypeSelected == index ? 6.r : 2.r,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        searchTypeSelected = index;
                                        if (index == 4) {
                                          searching = true;
                                          notifier.searchCustomer("", 4);
                                        }
                                      });
                                      context.popRoute();
                                    },
                                    title: Text(searchType[index].toString()),
                                  );
                                },
                              ),
                              50.verticalSpace,
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    FlutterRemix.sound_module_line,
                    size: 24.r,
                    color: AppColors.black,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const CustomBouncingScrollPhysics(),
                  padding: REdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  itemCount: searching ? state.customersAfterFilter!.length : state.customers!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final customer = searching ? state.customersAfterFilter![index] : state.customers![index];
                    return CustomerItemWidget(
                      userRole: LocalStorage.instance.getShareMode() ? notifierBase.getRoleCode().where((e) => e.contains("pos-")).first : "",
                      customer: customer,
                      onDeleteTap: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return WDeleteCustomerDialog(
                              alias: customer.id!,
                            );
                          },
                        );
                      },
                      onEditCustomerTap: () {
                        context.pushRoute(
                          UpdateCustomerPasRoute(
                            customer: customer,
                          ),
                        );
                      },
                      onChat: () {},
                      onEditRoleTap: () {},
                      //  () => showModalBottomSheet(
                      //   context: context,
                      //   builder: (context) =>
                      //       UserRolesModalInUsers(userData: customer),
                      // ),
                    );
                  },
                ),
              )
            ],
          );
  }

  Widget tabShop(CustomersState state) {
    return state.shops!.isEmpty
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.greenMain,
              strokeWidth: 3.r,
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const CustomBouncingScrollPhysics(),
                  padding: REdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 30,
                  ),
                  itemCount: state.shops!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final shop = state.shops![index];
                    return ShopItemWidget(
                      shop: shop,
                      onEditShopTap: () {},
                      // () => context.pushRoute(
                      //   EditUserRoute(
                      //     uuid: customer.uuid,
                      //     title:
                      //         '${customer.firstname ?? ''} ${customer.lastname ?? ''}',
                      //     from: OpenEditUserFrom.users,
                      //   ),
                      // ),
                      onEditRoleTap: () {},
                      //  () => showModalBottomSheet(
                      //   context: context,
                      //   builder: (context) =>
                      //       UserRolesModalInUsers(userData: customer),
                      // ),
                    );
                  },
                ),
              )
            ],
          );
  }

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customersProvider);
    final notifier = ref.read(customersProvider.notifier);
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        backgroundColor: AppColors.mainBackground,
        appBar: CustomAppbarPOS(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 11.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.greenMain,
                  minimumSize: const Size(83, 34),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(43),
                  ),
                ),
                onPressed: () {
                  context.pushRoute(const AddCustomerPasRoute());
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: AppColors.white, size: 16.r),
                    4.horizontalSpace,
                    Text(
                      "Add",
                      style: AppTypographies.styWhite12W500,
                    ),
                  ],
                ),
              ),
            ),
            15.horizontalSpace,
          ],
          title: Text(
            "Khách hàng và cửa hàng",
            style: AppTypographies.styBlack16W500,
            textAlign: TextAlign.center,
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
        ),
        body: Container(
          decoration: const BoxDecoration(color: AppColors.mainBackground),
          child: Column(
            children: [
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
                  tabs: const [
                    Tab(text: "Khách hàng"),
                    Tab(text: "Cửa hàng"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const CustomBouncingScrollPhysics(),
                  children: [tabCustomer(state, notifier), tabShop(state)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
