import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaxCustomerCategoryItem extends ConsumerWidget {
  final dynamic taxCusCategory;
  final Function()? onEditTap;
  final Function()? onDeleteTap;

  const TaxCustomerCategoryItem({
    Key? key,
    required this.taxCusCategory,
    this.onEditTap,
    this.onDeleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: Colors.white),
        child: ListTile(
            leading: GestureDetector(
              onTap: onEditTap,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  FlutterRemix.file_paper_2_line,
                  color: Colors.black,
                ),
              ),
            ),
            title: Text(taxCusCategory["name"].toString()),
            trailing: GestureDetector(
              onTap: onDeleteTap,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  FlutterRemix.delete_bin_line,
                  color: Colors.black,
                ),
              ),
            )),
      ),
    );
  }
}
