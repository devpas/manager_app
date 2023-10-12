import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/presentation/theme/app_typographies.dart';

import '../../../../theme/theme.dart';

class PrinterItem extends ConsumerWidget {
  final dynamic printer;
  final Function()? onActive;
  final Function()? onEditTap;
  final Function()? onDeleteTap;
  final bool selected;

  const PrinterItem({Key? key, required this.printer, required this.onActive, required this.onEditTap, required this.onDeleteTap, required this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: Colors.white),
        child: ListTile(
          leading: GestureDetector(
            onTap: onEditTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                printer["type"] == "wifi" ? FlutterRemix.wifi_line : FlutterRemix.bluetooth_line,
                color: Colors.black,
              ),
            ),
          ),
          title: Text(
            printer["name"].toString(),
            style: TextStyle(color: selected ? AppColors.greenMain : AppColors.black),
          ),
          subtitle: Text(
            "Địa chỉ: ${printer["address"] ?? ""}",
            style: TextStyle(color: selected ? AppColors.greenMain : AppColors.black),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onActive,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    selected ? FlutterRemix.stop_fill : FlutterRemix.play_line,
                    color: Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onEditTap,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    FlutterRemix.edit_2_line,
                    color: Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onDeleteTap,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    FlutterRemix.delete_bin_line,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
