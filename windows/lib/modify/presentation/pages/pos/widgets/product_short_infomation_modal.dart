import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/models.dart';
import '../../../../presentation/components/components.dart';
import '../../../../presentation/theme/theme.dart';
import '../../../../riverpob/providers/providers.dart';

class ProductShortInfoModal extends ConsumerStatefulWidget {
  final ProductPasData? product;
  ProductShortInfoModal({Key? key, this.product}) : super(key: key);

  @override
  ConsumerState<ProductShortInfoModal> createState() =>
      _ProductShortInfoModalState(product);
}

class _ProductShortInfoModalState extends ConsumerState<ProductShortInfoModal> {
  final ProductPasData? product;

  _ProductShortInfoModalState(this.product);
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final state = ref.watch(categoriesPASProvider);
    return Material(
      color: AppColors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: Text(
                        product!.name.toString(),
                        style: AppTypographies.styBlack16W500,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          context.popRoute();
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                10.verticalSpace,
                Row(
                  children: [
                    CommonImage(
                      imageUrl: product!.image,
                      width: 150,
                      height: 200,
                    ),
                    Column(
                      children: [
                        SizedBox(
                            width: screenWidth * 0.5,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("Giá mua: ${product!.priceBuy}",
                                  style: AppTypographies.styBlack12W400),
                            )),
                        SizedBox(
                            width: screenWidth * 0.5,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("Giá bán: ${product!.priceSell}",
                                  style: AppTypographies.styBlack12W400),
                            )),
                        SizedBox(
                            width: screenWidth * 0.5,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("Mã vạch: ${product!.reference}",
                                  style: AppTypographies.styBlack12W400),
                            )),
                        SizedBox(
                            width: screenWidth * 0.5,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("Code: ${product!.code}",
                                  style: AppTypographies.styBlack12W400),
                            )),
                        SizedBox(
                            width: screenWidth * 0.5,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                  "Danh mục: ${state.categories!.where((category) => category.id == product!.categoryId).first.name}",
                                  style: AppTypographies.styBlack12W400),
                            )),
                        SizedBox(
                            width: screenWidth * 0.5,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                  "Trạng thái: ${product!.active == 1 ? "Hoạt động" : "Không hoạt động"}",
                                  style: AppTypographies.styBlack12W400),
                            )),
                      ],
                    )
                  ],
                ),
                200.verticalSpace,
              ],
            ),
          ),
          const BlurLoadingWidget(isLoading: false),
        ],
      ),
    );
  }
}
