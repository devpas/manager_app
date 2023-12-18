import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StockItem extends ConsumerWidget {
  final dynamic warehouse;
  final Function()? onEditTap;
  final Function()? onDeleteTap;

  const StockItem({
    Key? key,
    required this.warehouse,
    this.onEditTap,
    this.onDeleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: Colors.white),
        child: InkWell(
          onTap: onEditTap,
          child: ListTile(
            title: Text(warehouse["name"].toString()),
            subtitle: Text("Địa chỉ: ${warehouse["address"] ?? ""}"),
            trailing: warehouse["id"] != 0 && warehouse["id"] != 1 && warehouse["id"] != 2
                ? InkWell(
                    onTap: onDeleteTap,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        FlutterRemix.delete_bin_line,
                        color: Colors.black,
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
