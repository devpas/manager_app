import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/constants.dart';
import '../theme/theme.dart';

class CommonImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final double? progressSize;
  final double radius;

  const CommonImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.progressSize,
    this.radius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius.r),
      child: CachedNetworkImage(
        imageUrl: '${AppConstants.imageBaseUrl}/$imageUrl',
        width: width,
        height: height,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, progress) {
          return Center(
            child: SizedBox(
              width: progressSize ?? ((width ?? 40) * 0.4),
              height: progressSize ?? ((width ?? 40) * 0.4),
              child: CircularProgressIndicator(
                strokeWidth: 3.r,
                color: AppColors.greenMain,
              ),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColors.mainBackground,
            ),
            alignment: Alignment.center,
            child: Icon(
              FlutterRemix.image_line,
              color: AppColors.black.withOpacity(0.5),
              size: 20.r,
            ),
          );
        },
      ),
    );
  }
}
