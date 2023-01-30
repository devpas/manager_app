import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'custom_check_box.dart';

class LanguageItem extends ConsumerWidget {
  final bool? isChecked;
  final String? text;
  final String? imageUrl;
  final Function()? onPress;

  const LanguageItem({
    Key? key,
    this.isChecked,
    this.text,
    this.imageUrl,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(0)),
        ),
        onPressed: onPress,
        child: Container(
          height: 60.r,
          padding: REdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(169, 169, 150, 0.13),
                offset: Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 0,
              )
            ],
            color: const Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: <Widget>[
              CustomCheckbox(isChecked: isChecked),
              Container(
                height: 15.r,
                width: 20.r,
                margin: REdgeInsets.only(left: 20, right: 8),
                child: CommonImage(
                  imageUrl: imageUrl,
                  width: 20,
                  height: 15,
                  radius: 0,
                ),
              ),
              Text(
                '$text',
                style: AppTypographies.styBlack14W500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
