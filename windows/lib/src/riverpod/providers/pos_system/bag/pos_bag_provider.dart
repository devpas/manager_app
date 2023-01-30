import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/dependency_manager.dart';
import '../../../notifiers/notifiers.dart';
import '../../../states/states.dart';

final posBagProvider =
    StateNotifierProvider.autoDispose<PosBagNotifier, PosBagState>(
  (ref) => PosBagNotifier(
    usersRepository,
    currenciesRepository,
    paymentsRepository,
    shopsRepository,
    productsRepository,
    ordersRepository,
  ),
);
