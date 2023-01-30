import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/theme.dart';
import '../../../components/components.dart';
import '../../../../core/constants/constants.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: CustomAppbar(
        title: TrKeys.notifications,
        leading: SmallIconButton(
          icon: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
            color: AppColors.black,
          ),
          onPressed: context.popRoute,
        ),
      ),
      body: ListView(
        physics: const CustomBouncingScrollPhysics(),
        padding: REdgeInsets.symmetric(vertical: 20, horizontal: 15),
        children: const [
          NotificationItem(
            notificationType: NotificationType.newOrder,
            date: '12.07.2021',
            order: '#548',
            amount: '\$ 149.00',
            user: 'Ronald Richards',
          ),
          NotificationItem(
            notificationType: NotificationType.newComment,
            date: '09.07.2021',
            commentOwner: 'Marvin McKinney',
            comment:
                'A good dress, also at a discount, I like everything about it ...',
          ),
          NotificationItem(
            notificationType: NotificationType.newComment,
            date: '09.07.2021',
            commentOwner: 'Cameron Williamson',
            comment:
                'A good dress, also at a discount, I like everything about it ...',
          ),
          NotificationItem(
            notificationType: NotificationType.newOrder,
            date: '12.07.2021',
            order: '#234',
            amount: '\$ 23.00',
            user: 'Esther Howard',
          ),
          NotificationItem(
            notificationType: NotificationType.newOrder,
            date: '12.07.2021',
            order: '#234',
            amount: '\$ 23.00',
            user: 'Esther Howard',
          ),
        ],
      ),
    );
  }
}
