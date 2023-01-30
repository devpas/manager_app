import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/dependency_manager.dart';
import '../../notifiers/notifiers.dart';
import '../../states/states.dart';

final addOrderProvider =
    StateNotifierProvider.autoDispose<AddOrderNotifier, AddOrderState>(
  (ref) => AddOrderNotifier(
    usersRepository,
    currenciesRepository,
    paymentsRepository,
    shopsRepository,
    productsRepository,
    categoriesRepository,
    brandsRepository,
      ordersRepository,
  ),
);
