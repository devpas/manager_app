import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/dependency_manager.dart';
import '../../../notifiers/notifiers.dart';
import '../../../states/states.dart';

final orderStatusProvider =
    StateNotifierProvider<OrderStatusNotifier, OrderStatusState>(
  (ref) => OrderStatusNotifier(ordersRepository),
);
