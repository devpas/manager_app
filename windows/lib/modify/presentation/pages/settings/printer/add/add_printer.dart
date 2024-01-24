import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../riverpob/states/states.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';

class AddPrinterPage extends ConsumerStatefulWidget {
  const AddPrinterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddPrinterPage> createState() => _AddPrinterPageState();
}

class _AddPrinterPageState extends ConsumerState<AddPrinterPage> {
  final _formKey = GlobalKey<FormState>();

  String address = "";
  String printerName = "";
  int typePrinter = 1;
  String nameDevice = "";

  @override
  void initState() {
    super.initState();
  }

  String getNameTypePrinter(BaseState state) {
    String nameTypePrinter = "";
    if (typePrinter == 1) {
      nameTypePrinter = state.translate[state.languageSelected]["wifi_printer"];
    } else if (typePrinter == 2) {
      nameTypePrinter = state.translate[state.languageSelected]["bluetooth_printer"];
    }
    return nameTypePrinter;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(baseProvider);
    final notifier = ref.read(baseProvider.notifier);
    return AbsorbPointer(
      absorbing: false,
      child: KeyboardDismisser(
        child: Scaffold(
          backgroundColor: AppColors.shopsPageBack,
          appBar: CustomAppbarPOS(
            title: Text(
              state.translate[state.languageSelected]["add_printer"],
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
                    30.verticalSpace,
                    Text(
                      state.translate[state.languageSelected]["name"],
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
                          printerName = e;
                        });
                      },
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        letterSpacing: -0.4,
                        color: AppColors.black,
                      ),
                    ),
                    30.verticalSpace,
                    SelectWithAddButton(
                      label: state.translate[state.languageSelected]["type_printer"],
                      title: getNameTypePrinter(state),
                      onSelectTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Padding(
                            padding: REdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                24.verticalSpace,
                                Text(
                                  state.translate[state.languageSelected]["select_type_printer"],
                                  style: AppTypographies.styBlack22W500,
                                ),
                                24.verticalSpace,
                                ListView(
                                  shrinkWrap: true,
                                  children: [
                                    ListTile(
                                      selected: typePrinter == 1 ? true : false,
                                      selectedColor: AppColors.greenMain,
                                      onTap: () {
                                        setState(() {
                                          typePrinter = 1;
                                        });
                                        context.popRoute();
                                      },
                                      title: Text(state.translate[state.languageSelected]["wifi_printer"]),
                                    ),
                                    ListTile(
                                        selected: typePrinter == 2 ? true : false,
                                        selectedColor: AppColors.greenMain,
                                        onTap: () {
                                          setState(() {
                                            typePrinter = 2;
                                          });
                                          context.popRoute();
                                        },
                                        title: Text(state.translate[state.languageSelected]["bluetooth_printer"]))
                                  ],
                                ),
                                50.verticalSpace,
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    30.verticalSpace,
                    Text(
                      typePrinter == 1 ? state.translate[state.languageSelected]["ip_address"] : "${state.translate[state.languageSelected]["device_name"]}: $nameDevice",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: -0.4,
                        color: AppColors.black.withOpacity(0.3),
                      ),
                    ),
                    10.verticalSpace,
                    typePrinter == 1
                        ? TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            onChanged: (e) {
                              setState(() {
                                address = e;
                              });
                            },
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              letterSpacing: -0.4,
                              color: AppColors.black,
                            ),
                          )
                        : ListTile(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            tileColor: AppColors.mainBackground,
                            onTap: () async {
                              final selected = await FlutterBluetoothPrinter.selectDevice(context);
                              if (selected != null) {
                                setState(() {
                                  address = selected.address;
                                  nameDevice = selected.name!;
                                });
                              }
                            },
                            title: Text(
                              address == "" ? state.translate[state.languageSelected]["bluetooth_select"] : address,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                letterSpacing: -0.4,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                    420.verticalSpace,
                    CommonAccentButton(
                      isLoading: state.printerLoading! ? true : false,
                      title: AppHelpers.getTranslation(TrKeys.save),
                      onPressed: () async {
                        if (printerName != "") {
                          var dataPrinter = {"name": printerName, "address": address, "type": typePrinter == 1 ? "wifi" : "bluetooth"};
                          await notifier.addPrinter(dataPrinter);
                          // if (context.mounted) {
                          //   if (state.printerLoading! == false) {
                          //     context.popRoute();
                          //   }
                          // }
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
