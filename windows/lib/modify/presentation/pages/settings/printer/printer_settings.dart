import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/products/product_provider.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:g_manager_app/src/core/utils/local_storage.dart';

import '../../../../../../../src/core/routes/app_router.gr.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'widgets/printer_item.dart';
import 'widgets/w_delete_printer_dialog.dart';
import 'widgets/printer_action.dart';

class ListPrinterPage extends ConsumerStatefulWidget {
  const ListPrinterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ListPrinterPage> createState() => _ListPrinterPageState();
}

class _ListPrinterPageState extends ConsumerState<ListPrinterPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(baseProvider.notifier).getListPrinters();
      },
    );
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(baseProvider);
    final notifier = ref.watch(baseProvider.notifier);
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        backgroundColor: AppColors.mainBackground,
        appBar: CustomAppbarPOS(
          actions: addPrinter(context),
          title: Text(
            "Danh sách máy in",
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
        body: state.printerLoading!
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
                        horizontal: 5,
                        vertical: 10,
                      ),
                      itemCount: state.printers!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final printer = state.printers![index];
                        return PrinterItem(
                          selected: printer["id"] == state.printerSelected["id"] ? true : false,
                          printer: printer,
                          onActive: () {
                            if (printer["id"] == state.printerSelected["id"]) {
                              notifier.stopPrinterActive();
                            } else {
                              notifier.setPrinterActive(printer);
                            }
                          },
                          onEditTap: () async {
                            context.pushRoute(
                              UpdatePrinterRoute(printer: printer),
                            );
                          },
                          onDeleteTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return DeleteWarehouseDialog(
                                  alias: printer["id"],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
