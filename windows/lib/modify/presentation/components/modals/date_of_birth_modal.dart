import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/core/constants/constants.dart';
import '../../../../src/core/utils/utils.dart';
import '../../../../src/presentation/theme/theme.dart';
import '../buttons/confirm_button.dart';

class DateOfBirthModal extends StatefulWidget {
  final String initialDate;
  final Function(DateTime? date) onDateSaved;

  const DateOfBirthModal({
    Key? key,
    required this.initialDate,
    required this.onDateSaved,
  }) : super(key: key);

  @override
  State<DateOfBirthModal> createState() => _DateOfBirthModalModalState();
}

class _DateOfBirthModalModalState extends State<DateOfBirthModal> {
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            24.verticalSpace,
            SizedBox(
              height: 300.r,
              child: CupertinoTheme(
                data: const CupertinoThemeData(
                  brightness: Brightness.light,
                ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: widget.initialDate.isEmpty
                      ? DateTime.now()
                      : DateTime.parse(widget.initialDate),
                  onDateTimeChanged: (DateTime value) {
                    date = value;
                  },
                ),
              ),
            ),
            16.verticalSpace,
            ConfirmButton(
              title: AppHelpers.getTranslation(TrKeys.save),
              onTap: () {
                widget.onDateSaved(date);
                context.popRoute();
              },
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
