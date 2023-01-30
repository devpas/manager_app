import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../models/models.dart';
import '../../../states/states.dart';

class AddOrderProductNotifier extends StateNotifier<AddOrderProductState> {
  AddOrderProductNotifier() : super(const AddOrderProductState());

  void setProduct(ProductData? product) {
    final List<Stocks> stocks = product?.stocks ?? <Stocks>[];
    state = state.copyWith(
      isLoading: false,
      product: product,
      initialStocks: stocks,
      stockCount: 0,
    );
    if (stocks.isNotEmpty) {
      final int groupsCount = stocks[0].extras?.length ?? 0;
      final List<int> selectedIndexes = List.filled(groupsCount, 0);
      initialSetSelectedIndexes(selectedIndexes);
    }
  }

  void updateSelectedIndexes({
    required int index,
    required int value,
  }) {
    final newList = state.selectedIndexes.sublist(0, index);
    newList.add(value);
    final postList =
        List.filled(state.selectedIndexes.length - newList.length, 0);
    newList.addAll(postList);
    initialSetSelectedIndexes(newList);
  }

  void initialSetSelectedIndexes(List<int> indexes) {
    state = state.copyWith(selectedIndexes: indexes);
    updateExtras();
  }

  void updateExtras() {
    final int groupsCount = state.initialStocks[0].extras?.length ?? 0;
    final List<TypedExtra> groupExtras = [];
    for (int i = 0; i < groupsCount; i++) {
      if (i == 0) {
        final TypedExtra extras = getFirstExtras(state.selectedIndexes[0]);
        groupExtras.add(extras);
      } else {
        final TypedExtra extras =
            getUniqueExtras(groupExtras, state.selectedIndexes, i);
        groupExtras.add(extras);
      }
    }
    final Stocks? selectedStock = getSelectedStock(groupExtras);
    final int minQty = state.product?.minQty ?? 0;
    final int selectedStockQty = selectedStock?.quantity ?? 0;
    final int stockCount =
        minQty <= selectedStockQty ? minQty : selectedStockQty;
    state = state.copyWith(
      typedExtras: groupExtras,
      selectedStock: selectedStock,
      stockCount: stockCount,
    );
  }

  Stocks? getSelectedStock(List<TypedExtra> groupExtras) {
    List<Stocks> stocks = List.from(state.initialStocks);
    for (int i = 0; i < groupExtras.length; i++) {
      String selectedExtrasValue =
          groupExtras[i].uiExtras[state.selectedIndexes[i]].value;
      stocks = getSelectedStocks(stocks, selectedExtrasValue, i);
    }
    return stocks[0];
  }

  List<Stocks> getSelectedStocks(List<Stocks> stocks, String value, int index) {
    List<Stocks> included = [];
    for (int i = 0; i < stocks.length; i++) {
      if (stocks[i].extras?[index].value == value) {
        included.add(stocks[i]);
      }
    }
    return included;
  }

  TypedExtra getFirstExtras(int selectedIndex) {
    ExtrasType type = ExtrasType.text;
    String title = '';
    final List<String> uniques = [];
    for (int i = 0; i < state.initialStocks.length; i++) {
      uniques.add(state.initialStocks[i].extras?[0].value ?? '');
      title = state.initialStocks[i].extras?[0].group?.translation?.title ?? '';
      type = AppHelpers.getExtraTypeByValue(
          state.initialStocks[i].extras?[0].group?.type);
    }
    final setOfUniques = uniques.toSet().toList();
    final List<UiExtra> extras = [];
    for (int i = 0; i < setOfUniques.length; i++) {
      if (selectedIndex == i) {
        extras.add(UiExtra(setOfUniques[i], true, i));
      } else {
        extras.add(UiExtra(setOfUniques[i], false, i));
      }
    }
    return TypedExtra(type, extras, title, 0);
  }

  TypedExtra getUniqueExtras(
    List<TypedExtra> groupExtras,
    List<int> selectedIndexes,
    int index,
  ) {
    List<Stocks> includedStocks = List.from(state.initialStocks);
    for (int i = 0; i < groupExtras.length; i++) {
      final String includedValue =
          groupExtras[i].uiExtras[selectedIndexes[i]].value;
      includedStocks = getIncludedStocks(includedStocks, i, includedValue);
    }
    final List<String> uniques = [];
    String title = '';
    ExtrasType type = ExtrasType.text;
    for (int i = 0; i < includedStocks.length; i++) {
      uniques.add(includedStocks[i].extras?[index].value ?? '');
      title = includedStocks[i].extras?[index].group?.translation?.title ?? '';
      type = AppHelpers.getExtraTypeByValue(
          includedStocks[i].extras?[index].group?.type ?? '');
    }
    final setOfUniques = uniques.toSet().toList();
    final List<UiExtra> extras = [];
    for (int i = 0; i < setOfUniques.length; i++) {
      if (selectedIndexes[groupExtras.length] == i) {
        extras.add(UiExtra(setOfUniques[i], true, i));
      } else {
        extras.add(UiExtra(setOfUniques[i], false, i));
      }
    }
    return TypedExtra(type, extras, title, index);
  }

  List<Stocks> getIncludedStocks(
    List<Stocks> includedStocks,
    int index,
    String includedValue,
  ) {
    List<Stocks> stocks = [];
    for (int i = 0; i < includedStocks.length; i++) {
      if (includedStocks[i].extras?[index].value == includedValue) {
        stocks.add(includedStocks[i]);
      }
    }
    return stocks;
  }

  void increaseStockCount() {
    if ((state.selectedStock?.quantity ?? 0) < (state.product?.minQty ?? 0)) {
      return;
    }
    int newCount = state.stockCount;
    if (newCount >= (state.product?.maxQty ?? 100000) ||
        newCount >= (state.selectedStock?.quantity ?? 100000)) {
      return;
    }
    if (newCount < (state.product?.minQty ?? 0)) {
      newCount = state.product?.minQty ?? 1;
      state = state.copyWith(stockCount: newCount);
    } else {
      newCount = newCount + 1;
      state = state.copyWith(stockCount: newCount);
    }
  }

  void decreaseStockCount() {
    int newCount = state.stockCount;
    if (newCount < 1) {
      return;
    }
    if (newCount <= (state.product?.minQty ?? 0)) {
      newCount = 0;
      state = state.copyWith(stockCount: newCount);
    } else {
      newCount = newCount - 1;
      state = state.copyWith(stockCount: newCount);
    }
  }

// void addProductToBag(
//     BuildContext context,
//     int bagIndex,
//     RightSideNotifier rightSideNotifier,
//     ) {
//   final List<BagProductData> bagProducts =
//       LocalStorage.instance.getBags()[bagIndex].bagProducts ?? [];
//   bool isProductAlreadyAdded = false;
//   int addedIndex = 0;
//   for (int i = 0; i < bagProducts.length; i++) {
//     if (bagProducts[i].stock?.product?.id == state.product?.id &&
//         bagProducts[i].stock?.id == state.selectedStock?.id) {
//       isProductAlreadyAdded = true;
//       addedIndex = i;
//       break;
//     }
//   }
//   if (isProductAlreadyAdded) {
//     final newCartProduct = bagProducts[addedIndex].copyWith(
//       quantity: (bagProducts[addedIndex].quantity ?? 0) + state.stockCount,
//     );
//     bagProducts[addedIndex] = newCartProduct;
//   } else {
//     bagProducts.insert(
//       0,
//       BagProductData(
//         stock: state.selectedStock,
//         quantity: state.stockCount,
//         product: state.product,
//       ),
//     );
//   }
//   List<BagData> bags = List.from(LocalStorage.instance.getBags());
//   bags[bagIndex] = bags[bagIndex].copyWith(bagProducts: bagProducts);
//   LocalStorage.instance.setBags(bags);
//   rightSideNotifier.fetchShops(
//     checkYourNetwork: () {
//       AppHelpers.showCheckFlash(
//         context,
//         AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
//       );
//     },
//   );
// }
}
