import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../modify/models/models.dart';
import '../../../../components/components.dart';
import '../../widgets/w_delete_category_dialog.dart';
import '../../widgets/w_sub_category_item.dart';

class WCategoryItem extends ConsumerWidget {
  final CategoryPasData category;
  final Function()? onEditTap;
  final Function()? onDeleteTap;

  const WCategoryItem({
    Key? key,
    required this.category,
    this.onEditTap,
    this.onDeleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomExpansionTile(
      tilePadding: EdgeInsets.zero,
      category: category,
      onDeleteTap: onDeleteTap,
      onEditTap: onEditTap,
      childrenPadding: REdgeInsets.only(left: 15),
      children: (category.children ?? [])
          .map(
            (e) => WSubCategoryItem(
              subCategory: e,
              onTap: onEditTap != null
                  ? () async {
                      // ref
                      //     .read(editCategoryProvider.notifier)
                      //     .fetchCategoryDetails(e.uuid ?? '');
                      // final shouldUpdate = await context.pushRoute(
                      //     EditCategoryRoute(alias: e.uuid ?? '')) as bool?;
                      // if (shouldUpdate != null && shouldUpdate) {
                      //   await ref
                      //       .read(categoriesProvider.notifier)
                      //       .updateCategories();
                      // }
                    }
                  : null,
              onDeleteTap: onDeleteTap != null
                  ? () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return WDeleteCategoryDialog(
                            alias: e.id!,
                          );
                        },
                      );
                    }
                  : null,
            ),
          )
          .toList(),
    );
  }
}
