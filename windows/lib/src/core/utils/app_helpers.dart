import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../models/models.dart';
import '../../presentation/theme/theme.dart';
import '../constants/constants.dart';
import 'local_storage.dart';

class AppHelpers {
  AppHelpers._();

  static String getUserRoleText(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return getTranslation(TrKeys.admin);
      case UserRole.seller:
        return getTranslation(TrKeys.seller);
      case UserRole.manager:
        return getTranslation(TrKeys.manager);
      case UserRole.deliveryman:
        return getTranslation(TrKeys.deliveryMan);
      case UserRole.user:
        return getTranslation(TrKeys.user);
      default:
        return getTranslation(TrKeys.deliveryMan);
    }
  }

  static UserRole getUserRoleEnum(String? value) {
    switch (value) {
      case 'admin':
        return UserRole.admin;
      case 'seller':
        return UserRole.seller;
      case 'manager':
        return UserRole.manager;
      case 'deliveryman':
        return UserRole.deliveryman;
      case 'user':
        return UserRole.user;
      default:
        return UserRole.deliveryman;
    }
  }

  static String getOrderStatusTextFromStatus(OrderStatus orderStatus) {
    switch (orderStatus) {
      case OrderStatus.newOrder:
        return getTranslation(TrKeys.newKey);
      case OrderStatus.accepted:
        return getTranslation(TrKeys.accepted);
      case OrderStatus.ready:
        return getTranslation(TrKeys.ready);
      case OrderStatus.onAWay:
        return getTranslation(TrKeys.onAWay);
      case OrderStatus.delivered:
        return getTranslation(TrKeys.delivered);
      case OrderStatus.canceled:
        return getTranslation(TrKeys.canceled);
      default:
        return getTranslation(TrKeys.newKey);
    }
  }

  static double getOrderStatusProgress(String? status) {
    switch (status) {
      case 'new':
        return 0.2;
      case 'accepted':
        return 0.4;
      case 'ready':
        return 0.6;
      case 'on_a_way':
        return 0.8;
      case 'delivered':
        return 1;
      case 'canceled':
        return 0;
      default:
        return 0.2;
    }
  }

  static String getOrderStatusText(String? value) {
    switch (value) {
      case 'new':
        return getTranslation(TrKeys.newKey);
      case 'accepted':
        return getTranslation(TrKeys.accepted);
      case 'ready':
        return getTranslation(TrKeys.ready);
      case 'on_a_way':
        return getTranslation(TrKeys.onAWay);
      case 'delivered':
        return getTranslation(TrKeys.delivered);
      case 'canceled':
        return getTranslation(TrKeys.canceled);
      default:
        return getTranslation(TrKeys.newKey);
    }
  }

  static OrderStatus getOrderStatusEnum(String? value) {
    switch (value) {
      case 'new':
        return OrderStatus.newOrder;
      case 'accepted':
        return OrderStatus.accepted;
      case 'ready':
        return OrderStatus.ready;
      case 'on_a_way':
        return OrderStatus.onAWay;
      case 'delivered':
        return OrderStatus.delivered;
      default:
        return OrderStatus.newOrder;
    }
  }

  static IconData getOrderStatusIcon(String? value) {
    switch (value) {
      case 'new':
        return FlutterRemix.flag_fill;
      case 'accepted':
        return FlutterRemix.check_double_fill;
      case 'ready':
        return FlutterRemix.check_fill;
      case 'on_a_way':
        return FlutterRemix.e_bike_2_fill;
      case 'delivered':
        return FlutterRemix.flag_fill;
      case 'canceled':
        return FlutterRemix.close_circle_fill;
      default:
        return FlutterRemix.flag_fill;
    }
  }

  static ExtrasType getExtraTypeByValue(String? value) {
    switch (value) {
      case 'color':
        return ExtrasType.color;
      case 'text':
        return ExtrasType.text;
      case 'image':
        return ExtrasType.image;
      default:
        return ExtrasType.text;
    }
  }

  static int getOrderProductsCount(OrderData orderData) {
    int count = 0;
    final List<ShopOrderDetails> orderDetails = orderData.details ?? [];
    for (int i = 0; i < orderDetails.length; i++) {
      count += orderData.details?[i].orderStocks?.length ?? 0;
    }
    return count;
  }

  static String getFormattedHour(String? value) {
    final date = DateTime.tryParse(value ?? DateTime.now().toString());
    final formatter = DateFormat('HH:mm');
    return formatter.format(date ?? DateTime.now());
  }

  static String getHour(TimeOfDay? value) {
    final time = value ?? TimeOfDay.now();
    return '${time.hour > 9 ? time.hour : '0${time.hour}'}:${time.minute > 9 ? time.minute : '0${time.minute}'}';
  }

  static String getShopStatusText(String? status) {
    switch (status) {
      case 'new':
        return getTranslation(TrKeys.newKey);
      case 'edited':
        return getTranslation(TrKeys.edited);
      case 'approved':
        return getTranslation(TrKeys.approved);
      case 'rejected':
        return getTranslation(TrKeys.rejected);
      default:
        return getTranslation(TrKeys.newKey);
    }
  }

  static Color getShopStatusColor(String? status) {
    switch (status) {
      case 'new':
        return AppColors.greenMain;
      case 'edited':
        return AppColors.totalPanelGradient1;
      case 'approved':
        return AppColors.darkBlue;
      case 'rejected':
        return AppColors.red;
      default:
        return AppColors.greenMain;
    }
  }

  static String getTranslation(String trKey) {
    final Map<String, dynamic> translations =
        LocalStorage.instance.getTranslations();
    for (final key in translations.keys) {
      if (trKey == key) {
        return translations[key];
      }
    }
    return trKey;
  }

  static showCheckFlash(BuildContext context, String text) {
    return showFlash(
      context: context,
      duration: const Duration(seconds: 3),
      builder: (BuildContext context, FlashController controller) {
        return Flash(
          controller: controller,
          backgroundColor: AppColors.mainBackground,
          position: FlashPosition.top,
          borderRadius: BorderRadius.circular(8.r),
          behavior: FlashBehavior.floating,
          margin: REdgeInsets.all(15),
          brightness: Brightness.light,
          barrierBlur: 1.5.r,
          barrierColor: Colors.black38,
          barrierDismissible: true,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColors.productBorder,
                width: 2.r,
              ),
            ),
            child: Padding(
              padding: REdgeInsets.all(15),
              child: Text(
                text,
                style: GoogleFonts.inter(
                  color: AppColors.black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }

  static DateTime getMinTime(String openTime) {
    final int openHour = int.parse(openTime.substring(3, 5)) == 0
        ? int.parse(openTime.substring(0, 2))
        : int.parse(openTime.substring(0, 2)) + 1;
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, openHour);
  }

  static DateTime getMaxTime(String closeTime) {
    final int closeHour = int.parse(closeTime.substring(0, 2));
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, closeHour);
  }
}
