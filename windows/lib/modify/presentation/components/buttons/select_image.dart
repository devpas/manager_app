import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../src/presentation/theme/theme.dart';
import '../common_image.dart';

class SelectImage extends StatelessWidget {
  final Function(XFile file) onChangePhoto;
  final XFile? file;
  final String? imageUrl;

  const SelectImage({
    Key? key,
    required this.onChangePhoto,
    this.file,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 142.r,
      width: 120.r,
      alignment: Alignment.center,
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Positioned(
            top: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Container(
                width: 120.r,
                height: 120.r,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 0, 0, 0.05),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: file != null
                    ? Image.file(
                        File(file!.path),
                        width: 120.r,
                        height: 120.r,
                        fit: BoxFit.cover,
                      )
                    : CommonImage(
                        imageUrl: imageUrl != null
                            ? imageUrl!
                            : "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg",
                        width: 120,
                        height: 120,
                        radius: 0,
                        progressSize: 20,
                      ),
              ),
            ),
          ),
          Positioned(
            top: 98.r,
            left: 38.r,
            child: Material(
              color: AppColors.commentHint,
              borderRadius: BorderRadius.circular(22.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(22.r),
                onTap: () async {
                  final XFile? pickedFile = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                    maxWidth: 1000,
                    maxHeight: 1000,
                    imageQuality: 90,
                  );
                  if (pickedFile != null) {
                    onChangePhoto(pickedFile);
                  }
                },
                child: Container(
                  height: 44.r,
                  width: 44.r,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.r),
                    border: Border.all(
                      width: 3.r,
                      color: AppColors.white,
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    color: AppColors.white,
                    size: 20.r,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SelectVideo extends StatelessWidget {
  final Function(XFile file) onChangePhoto;
  final XFile? file;
  final String? imageUrl;

  const SelectVideo({
    Key? key,
    required this.onChangePhoto,
    this.file,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 142.r,
      width: 120.r,
      alignment: Alignment.center,
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Positioned(
            top: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Container(
                width: 120.r,
                height: 120.r,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 0, 0, 0.05),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: CommonVideo(
                  imageUrl: imageUrl,
                  width: 120,
                  height: 120,
                  radius: 0,
                  progressSize: 20,
                ),
              ),
            ),
          ),
          Positioned(
            top: 98.r,
            left: 38.r,
            child: Material(
              color: AppColors.commentHint,
              borderRadius: BorderRadius.circular(22.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(22.r),
                onTap: () async {
                  final XFile? pickedFile = await ImagePicker().pickVideo(
                    source: ImageSource.gallery,
                  );
                  if (pickedFile != null) {
                    onChangePhoto(pickedFile);
                  }
                },
                child: Container(
                  height: 44.r,
                  width: 44.r,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.r),
                    border: Border.all(
                      width: 3.r,
                      color: AppColors.white,
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    color: AppColors.white,
                    size: 20.r,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
