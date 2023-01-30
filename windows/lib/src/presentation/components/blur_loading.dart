import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme.dart';

class BlurLoadingWidget extends StatelessWidget {
  final bool isLoading;

  const BlurLoadingWidget({Key? key, this.isLoading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.7, sigmaY: 1.7),
            child: Container(
              width: 40.r,
              height: 40.r,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 3.r,
                color: AppColors.greenMain,
              ),
            ),
          )
        : const SizedBox();
  }
}
