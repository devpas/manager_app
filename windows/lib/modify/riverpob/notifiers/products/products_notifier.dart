import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../modify/repository/products_repository.dart';
import '../../../../src/core/handlers/handlers.dart';
import '../../../models/data/category_data.dart';
import '../../../models/data/product_data.dart';
import '../../states/states.dart';

class ProductsPasNotifier extends StateNotifier<ProductsPasState> {
  ProductsPasNotifier(this._productsPASRepository)
      : super(
          const ProductsPasState(),
        );

  final ProductsPASRepository _productsPASRepository;

  String keySearch = "";
  String codeRef = "";
  String productName = "";
  double priceBuy = -1;
  double priceSell = -1;
  int minCategoryId = -1;
  List<ProductPasData> listProductAfterSearch = [];
  List<ProductPasData> listProductCache = [];
  Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;

  Future<void> fetchProductsPos() async {
    final response = await _productsPASRepository.getProduct("");
    response.when(
      success: (data) async {
        listProductCache = data.products!;
        minCategoryId = data.products![0].categoryId!;
        for (int i = 0; i < data.products!.length; i++) {
          if (data.products![i].categoryId! < minCategoryId) {
            minCategoryId = data.products![i].categoryId!;
          }
        }
        state = state.copyWith(products: data.products!.where((product) => product.categoryId == minCategoryId).toList());
      },
      failure: (failure) {
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          debugPrint('==> get brands failure: $failure');
        }
      },
    );
    state = state.copyWith(productsLoading: false);
  }

  Future<void> fetchProducts() async {
    state = state.copyWith(productsLoading: true);
    final response = await _productsPASRepository.getProduct("");
    response.when(
      success: (data) async {
        state = state.copyWith(products: data.products, productSelected: data.products![0]);
        listProductCache = state.products!;
      },
      failure: (failure) {
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          debugPrint('==> get brands failure: $failure');
        }
      },
    );
    state = state.copyWith(productsLoading: false);
  }

  Future<void> fetchProductsByCategory(int? categoryId) async {
    state = state.copyWith(productsLoading: true);
    String alias = "categoryId=$categoryId&";
    final response = await _productsPASRepository.getProduct(alias);
    response.when(
      success: (data) async {
        state = state.copyWith(products: data.products, productSelected: data.products![0]);
      },
      failure: (failure) {
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          debugPrint('==> get brands failure: $failure');
        }
      },
    );
    state = state.copyWith(productsLoading: false);
  }

  void getProductByCategory(int? categoryId) async {
    var listProductAfterFilter = listProductCache;
    listProductAfterFilter = listProductAfterFilter.where((product) => product.categoryId == categoryId).toList();
    state = state.copyWith(products: listProductAfterFilter);
  }

  void filterProduct(CategoryPasData categorySelected, List<ProductPasData> data, String productName) {
    print(categorySelected.id);
    if (categorySelected.id != -1) {
      data = data.where((product) => product.categoryId == categorySelected.id).toList();
    }

    if (productName.isNotEmpty) {
      data = data.where((product) => product.name!.toLowerCase().contains(productName.toLowerCase())).toList();
    }

    Future.delayed(const Duration(milliseconds: 100), () {
      state = state.copyWith(productsAfterFilter: data);
      keySearch = productName;
    });
  }

  void searchProducts(int categoryId) {
    listProductAfterSearch = [];
    print("$categoryId,$codeRef,$productName,$priceBuy,$priceSell");

    List<List> searchParam = [];
    if (categoryId != -1) {
      searchParam.add(["categoryId", categoryId]);
    }
    if (codeRef != "") {
      searchParam.add(["codeRef", codeRef]);
    }
    if (productName != "") {
      searchParam.add(["productName", productName.toLowerCase().contains(productName.toLowerCase())]);
    }
    if (priceBuy != -1) {
      searchParam.add(["priceBuy", priceBuy]);
    }
    if (priceSell != -1) {
      searchParam.add(["priceSell", priceSell]);
    }

    for (int i = 0; i < listProductCache.length; i++) {
      List<List> valueProductForSearch = [];
      if (categoryId != -1) {
        valueProductForSearch.add(["categoryId", listProductCache[i].categoryId]);
      }
      if (codeRef != "") {
        valueProductForSearch.add(["codeRef", listProductCache[i].reference]);
      }
      if (productName != "") {
        valueProductForSearch.add(["productName", listProductCache[i].name!.toLowerCase().contains(productName.toLowerCase())]);
      }
      if (priceBuy != -1) {
        valueProductForSearch.add(["priceBuy", listProductCache[i].priceBuy]);
      }
      if (priceSell != -1) {
        valueProductForSearch.add(["priceSell", listProductCache[i].priceSell]);
      }

      if (unOrdDeepEq(searchParam, valueProductForSearch) == true) {
        listProductAfterSearch.add(listProductCache[i]);
      }
    }
    state = state.copyWith(productsAfterFilter: listProductAfterSearch);
  }

  List<ProductPasData> searchAndAddProductInTicketByRefCode(String refCode) {
    print(refCode);
    List<ProductPasData> listProductSearchByRefCode = [];
    listProductSearchByRefCode = listProductCache.where((product) => product.reference!.toLowerCase().contains(refCode.toLowerCase())).toList();
    return listProductSearchByRefCode;
  }

  void resetSearch() {
    productName = "";
    priceBuy = -1;
    priceSell = -1;
    codeRef = "";
    state = state.copyWith(productsAfterFilter: []);
  }

  void setProductSelected(ProductPasData product) {
    state = state.copyWith(productSelected: product);
  }

  Future<void> addProduct(ProductPasData product) async {
    state = state.copyWith(productsLoading: true);
    final response = await _productsPASRepository.addProduct(product);
    response.when(
      success: (data) async {
        fetchProductsPos();
      },
      failure: (failure) {
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          debugPrint('==> get brands failure: $failure');
        }
      },
    );
    state = state.copyWith(productsLoading: false);
  }

  Future<void> updateProduct(ProductPasData product) async {
    state = state.copyWith(productsLoading: true);
    final response = await _productsPASRepository.updateProduct(product);
    response.when(
      success: (data) async {
        fetchProductsPos();
      },
      failure: (failure) {
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          debugPrint('==> get brands failure: $failure');
        }
      },
    );
    state = state.copyWith(productsLoading: false);
  }

  Future<void> deleteProduct(int productId) async {
    state = state.copyWith(productsLoading: true);
    final response = await _productsPASRepository.deleteProduct(productId);
    response.when(
      success: (data) async {
        fetchProductsPos();
      },
      failure: (failure) {
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          debugPrint('==> get brands failure: $failure');
        }
      },
    );
    state = state.copyWith(productsLoading: false);
  }

  Future<void> getListWarehouses() async {
    state = state.copyWith(warehouseLoading: true);
    final response = await _productsPASRepository.getListWarehouses();
    if (response["data"] != null) {
      state = state.copyWith(warehouse: response["data"], warehouseLoading: false, warehouseSelected: response["data"][0]);
    } else {
      print(response);
    }
  }

  Future<void> addWarehouse(dynamic data) async {
    state = state.copyWith(warehouseLoading: true);
    final response = await _productsPASRepository.addWarehouse(data);
    if (response["msg"] == "add warehouse successful") {
      await getListWarehouses();
    } else {
      print(response);
    }
  }

  Future<void> updateWarehouse(dynamic data) async {
    state = state.copyWith(warehouseLoading: true);
    final response = await _productsPASRepository.updateWarehouse(data);
    if (response["msg"] == "update warehouse successful") {
      await getListWarehouses();
    } else {
      print(response);
    }
  }

  Future<void> deleteWarehouse(int warehouseId) async {
    state = state.copyWith(warehouseLoading: true);
    final response = await _productsPASRepository.deleteWarehouse(warehouseId);
    if (response["msg"] == "delete warehouse successful") {
      await getListWarehouses();
    } else {
      print(response);
    }
  }

  void setWarehouseSelected(dynamic warehouse) {
    state = state.copyWith(warehouseSelected: warehouse);
  }

  void loadWarehouseSelected(int warehouseId) {
    var warehouse = state.warehouse!.where((warehouse) => warehouse["id"] == warehouseId).first;
    state = state.copyWith(warehouseSelected: warehouse);
  }

  Future<void> updateStockLimit(dynamic stockData) async {
    state = state.copyWith(updateStockLoading: true);
    final response = await _productsPASRepository.updateStockLimit(stockData);
    if (response["msg"] == "update stocks successful") {
      await fetchProducts();
      state = state.copyWith(updateStockLoading: false);
    } else {
      print(response);
    }
  }

  Future<void> addStockDiary(dynamic stockData) async {
    state = state.copyWith(updateStockLoading: true);
    final response = await _productsPASRepository.addStockDiary(stockData);

    if (response["msg"] != "") {
      await fetchProducts();
      state = state.copyWith(updateStockLoading: false);
    } else {
      print(response);
    }
  }

  Future<void> getListCustomerType() async {
    state = state.copyWith(taxCusCategoryLoading: true);
    final response = await _productsPASRepository.getListTaxCustomer();
    if (response["data"] != null) {
      state = state.copyWith(taxCusCategories: response["data"], taxCusCategoryLoading: false, taxCusCategorySelected: response["data"][0]);
    } else {
      print(response);
    }
  }

  Future<void> addTaxCusCategory(dynamic data) async {
    state = state.copyWith(taxCusCategoryLoading: true);
    final response = await _productsPASRepository.addTaxCusCategory(data);
    if (response["msg"] == "add tax customer category successful") {
      await getListCustomerType();
    } else {
      print(response);
    }
  }

  Future<void> updateTaxCusCategory(dynamic data) async {
    state = state.copyWith(taxCusCategoryLoading: true);
    final response = await _productsPASRepository.updateTaxCusCategory(data);
    if (response["msg"] == "update tax customer category successful") {
      await getListCustomerType();
    } else {
      print(response);
    }
  }

  Future<void> deleteTaxCusCategory(dynamic data) async {
    state = state.copyWith(taxCusCategoryLoading: true);
    final response = await _productsPASRepository.deleteTaxCusCategory(data);
    if (response["msg"] == "delete tax customer category successful") {
      await getListCustomerType();
    } else {
      print(response);
    }
  }

  Future<void> getListTaxCategories() async {
    state = state.copyWith(taxCategoryLoading: true);
    final response = await _productsPASRepository.getListTaxCategories();
    if (response["data"] != null) {
      state = state.copyWith(taxCategories: response["data"], taxCategoryLoading: false, taxCategorySelected: response["data"][0]);
    } else {
      print(response);
    }
  }

  Future<void> addTaxCategory(dynamic data) async {
    state = state.copyWith(taxCategoryLoading: true);
    final response = await _productsPASRepository.addTaxCategory(data);
    if (response["msg"] == "add tax category successful") {
      await getListTaxCategories();
    } else {
      print(response);
    }
  }

  Future<void> updateTaxCategory(dynamic data) async {
    state = state.copyWith(taxCategoryLoading: true);
    final response = await _productsPASRepository.updateTaxCategory(data);
    if (response["msg"] == "update tax category successful") {
      await getListTaxCategories();
    } else {
      print(response);
    }
  }

  Future<void> deleteTaxCategory(dynamic data) async {
    state = state.copyWith(taxCategoryLoading: true);
    final response = await _productsPASRepository.deleteTaxCategory(data);
    if (response["msg"] == "delete tax category successful") {
      await getListTaxCategories();
    } else {
      print(response);
    }
  }

  Future<void> getListTaxes() async {
    state = state.copyWith(taxLoading: true);
    final response = await _productsPASRepository.getListTaxes();
    if (response["data"] != null) {
      state = state.copyWith(taxes: response["data"], taxLoading: false, taxSelected: response["data"][0]);
    } else {
      print(response);
    }
  }

  void setTaxSelected(var tax) {
    state = state.copyWith(taxSelected: tax);
  }

  void setTaxCategorySelected(var taxCategory) {
    state = state.copyWith(taxCategorySelected: taxCategory);
  }

  Future<void> addTax(dynamic data) async {
    state = state.copyWith(taxLoading: true);
    final response = await _productsPASRepository.addTax(data);
    if (response["msg"] == "add tax successful") {
      await getListTaxes();
    } else {
      print(response);
    }
  }

  Future<void> updateTax(dynamic data) async {
    state = state.copyWith(taxLoading: true);
    final response = await _productsPASRepository.updateTax(data);
    if (response["msg"] == "update tax successful") {
      await getListTaxes();
    } else {
      print(response);
    }
  }

  Future<void> deleteTax(dynamic data) async {
    state = state.copyWith(taxLoading: true);
    final response = await _productsPASRepository.deleteTax(data);
    if (response["msg"] == "delete tax successful") {
      await getListTaxes();
    } else {
      print(response);
    }
  }

  double taxCalculate(String taxCusCategory, String taxCategory) {
    var taxes = state.taxes!;
    double tax = 0.0;
    for (int i = 0; i < taxes.length; i++) {
      if (taxes[i]["tax_category_id"] == taxCategory && taxes[i]["tax_customer_category_id"] == taxCusCategory) {
        tax = double.parse(taxes[i]["rate"].toString());
      }
    }
    print(tax);
    return tax;
  }
}
