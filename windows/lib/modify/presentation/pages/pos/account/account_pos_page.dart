import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/utils/utils.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class AccountPosPage extends ConsumerStatefulWidget {
  const AccountPosPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountPosPage> createState() => _AccountPosPageState();
}

class _AccountPosPageState extends ConsumerState<AccountPosPage> {
  final _formKey = GlobalKey<FormState>();
  String paymentMethod = "Tiền mặt";
  String note = "";
  double money = 0;
  bool checkMoney = true;
  @override
  Widget build(BuildContext context) {
    final stateBase = ref.watch(baseProvider);
    final notifierBase = ref.read(baseProvider.notifier);
    return AbsorbPointer(
      absorbing: false,
      child: KeyboardDismisser(
        child: Scaffold(
          backgroundColor: AppColors.shopsPageBack,
          appBar: CustomAppbarPOS(
            title: Text(
              "Chuyển khoản nội bộ",
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              physics: const CustomBouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Số tiền hiện có : ${stateBase.moneyWallet.toStringAsFixed(2)}",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: -0.4,
                        color: AppColors.black.withOpacity(0.3),
                      ),
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (e) {
                        setState(() {
                          if (e != "") {
                            money = double.parse(e);
                          }
                        });
                      },
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        letterSpacing: -0.4,
                        color: AppColors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: "Số tiền cần chuyển",
                        hintStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          letterSpacing: -0.4,
                          color: AppColors.inputNameHint,
                        ),
                      ),
                    ),
                    30.verticalSpace,
                    SelectWithSearchButton(
                      label: "Phương thức thanh toán",
                      title: paymentMethod,
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(builder: (BuildContext context, StateSetter setModelState) {
                                return Material(
                                  color: AppColors.mainBackground,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: 20,
                                      left: 15,
                                      right: 15,
                                      bottom: MediaQuery.of(context).viewInsets.bottom,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SearchTextField(
                                          onChanged: (v) {
                                            setModelState(() {});
                                          },
                                          hintText: "Tìm tài khoản",
                                        ),
                                        10.verticalSpace,
                                        SearchedItem(
                                          title: "Tiền mặt",
                                          isSelected: false,
                                          onTap: () {
                                            setState(() {
                                              paymentMethod = "Tiền mặt";
                                            });
                                            Navigator.pop(context);
                                          },
                                        ),
                                        // Expanded(
                                        //   child: ListView.builder(
                                        //     padding: const EdgeInsets.symmetric(vertical: 10),
                                        //     physics: const CustomBouncingScrollPhysics(),
                                        //     itemCount: 0,
                                        //     shrinkWrap: true,
                                        //     itemBuilder: (context, index) {
                                        //       return SearchedItem(
                                        //         title: 'Tên tài khoản',
                                        //         isSelected: false,
                                        //         onTap: () {
                                        //           setState(() {});
                                        //           Navigator.pop(context);
                                        //         },
                                        //       );
                                        //     },
                                        //   ),
                                        // ),
                                        30.verticalSpace,
                                      ],
                                    ),
                                  ),
                                );
                              });
                            });
                      },
                    ),
                    30.verticalSpace,
                    Text(
                      "Cơ sở: ${stateBase.baseInfomation["base_name"]}",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),
                    30.verticalSpace,
                    Text(
                      "Email: ${stateBase.baseInfomation["email"]}",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),
                    30.verticalSpace,
                    Text(
                      "Tên: ${stateBase.baseInfomation["owner_name"]}",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),
                    30.verticalSpace,
                    Text(
                      "SĐT: ${stateBase.baseInfomation["phone"]}",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),
                    30.verticalSpace,
                    TextField(
                      onChanged: (e) {
                        setState(() {
                          note = e;
                        });
                      },
                      decoration: const InputDecoration(hintText: "Ghi chú"),
                      maxLines: 10,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),
                    30.verticalSpace,
                    checkMoney
                        ? const SizedBox()
                        : Text(
                            "Số tiền chuyển lớn hơn số tiền đang có",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.red,
                            ),
                          ),
                    80.verticalSpace,
                    CommonAccentButton(
                      isLoading: stateBase.sendMoneyLoading! ? true : false,
                      title: "Chuyển tiền",
                      onPressed: () {
                        if (money <= stateBase.moneyWallet) {
                          notifierBase.createOrder(money, -2, 0, paymentMethod, "${stateBase.baseRootInfomation["email"]}_${stateBase.baseInfomation["email"]}", note);
                        } else {
                          setState(() {
                            checkMoney = false;
                          });
                        }
                      },
                    ),
                    30.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
