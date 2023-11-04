import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/utils/utils.dart';

class ProccessPage extends ConsumerStatefulWidget {
  const ProccessPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProccessPage> createState() => _ProccessPageState();
}

class _ProccessPageState extends ConsumerState<ProccessPage> {
  String paymentMethod = "Tiền mặt";
  String note = "";
  double money = 0;
  bool checkMoney = true;
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Trang đang trong quá trình xây dựng, cập nhật"));
  }
}
