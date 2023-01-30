import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/dependency_manager.dart';
import '../../../notifiers/notifiers.dart';
import '../../../states/states.dart';

final editUserProvider =
    StateNotifierProvider.autoDispose<EditUserNotifier, EditUserState>(
  (ref) => EditUserNotifier(
    usersRepository,
    galleryRepository,
    ordersRepository,
  ),
);
