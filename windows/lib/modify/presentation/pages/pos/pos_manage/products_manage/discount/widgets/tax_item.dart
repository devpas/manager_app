import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaxItem extends ConsumerWidget {
  final dynamic tax;
  final Function()? onEditTap;
  final Function()? onDeleteTap;

  const TaxItem({
    Key? key,
    required this.tax,
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
            leading: InkWell(
              onTap: onEditTap,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  FlutterRemix.file_paper_2_line,
                  color: Colors.black,
                ),
              ),
            ),
            title: Text(tax["name"].toString()),
            trailing: InkWell(
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
