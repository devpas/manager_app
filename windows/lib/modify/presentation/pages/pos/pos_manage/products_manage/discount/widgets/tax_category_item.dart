import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaxCategoryItem extends ConsumerWidget {
  final dynamic taxCategory;
  final Function()? onEditTap;
  final Function()? onDeleteTap;

  const TaxCategoryItem({
    Key? key,
    required this.taxCategory,
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
            title: Text(taxCategory["name"].toString()),
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
