// ignore_for_file: no_logic_in_create_state

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/data/ticketline_data.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:g_manager_app/src/core/utils/app_helpers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';

class ProductEditModal extends ConsumerStatefulWidget {
  const ProductEditModal(
      this.ticketline, this.ticketIndex, this.ticketLineIndex,
      {super.key});

  final TicketLineData? ticketline;

  final int? ticketIndex;

  final int? ticketLineIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductEditModalState(ticketline, ticketIndex, ticketLineIndex);
}

class _ProductEditModalState extends ConsumerState<ProductEditModal> {
  _ProductEditModalState(
      this.ticketline, this.ticketIndex, this.ticketLineIndex);

  final TicketLineData? ticketline;

  final int? ticketIndex;

  final int? ticketLineIndex;

  TextEditingController unitController = TextEditingController(text: "0");
  TextEditingController priceAndTaxController =
      TextEditingController(text: "0");
  TextEditingController priceController = TextEditingController(text: "0");

  @override
  void initState() {
    super.initState();
    unitController.text = ticketline!.unit.toString();
    priceAndTaxController.text =
        (ticketline!.price! * (1 + int.parse("${ticketline!.taxId}") / 100))
            .toStringAsFixed(2);
    priceController.text = ticketline!.price!.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final statePos = ref.watch(posSystemPASProvider);
    final stateProduct = ref.watch(productsPASProvider);
    final notifierPos = ref.read(posSystemPASProvider.notifier);
    final notifierProduct = ref.read(productsPASProvider.notifier);
    return Material(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 23,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${notifierProduct.listProductCache.where((product) => product.id == ticketline!.productId).toList().first.name}",
              // "${stateProduct.products!.where((product) => product.id == ticketline!.productId).toList().first.name}",
              style: AppTypographies.styBlack22W500,
            ),
            40.verticalSpace,
            Text(
              AppHelpers.getTranslation("Số lượng"),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: -0.4,
                color: AppColors.black.withOpacity(0.3),
              ),
            ),
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.number,
              controller: unitController,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (input) => {},
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: -0.4,
                color: AppColors.black,
              ),
              decoration: InputDecoration(
                hintStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  letterSpacing: -0.4,
                  color: AppColors.inputNameHint,
                ),
              ),
            ),
            20.verticalSpace,
            Text(
              AppHelpers.getTranslation("Giá"),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: -0.4,
                color: AppColors.black.withOpacity(0.3),
              ),
            ),
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (input) => {
                if (input.isNotEmpty)
                  {
                    priceAndTaxController.text =
                        (double.parse(input) * (1 + ticketline!.taxId! / 100))
                            .toStringAsFixed(2),
                  }
              },
              controller: priceController,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: -0.4,
                color: AppColors.black,
              ),
              decoration: InputDecoration(
                hintStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  letterSpacing: -0.4,
                  color: AppColors.inputNameHint,
                ),
              ),
            ),
            20.verticalSpace,
            Text(
              AppHelpers.getTranslation("Giá + thuế"),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: -0.4,
                color: AppColors.black.withOpacity(0.3),
              ),
            ),
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.number,
              controller: priceAndTaxController,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (input) => {
                priceController.text =
                    (double.parse(input) / (1 + ticketline!.taxId! / 100))
                        .toStringAsFixed(2),
                if (input.isNotEmpty)
                  {
                    priceController.text =
                        (double.parse(input) / (1 + ticketline!.taxId! / 100))
                            .toStringAsFixed(2),
                  }
              },
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: -0.4,
                color: AppColors.black,
              ),
              decoration: InputDecoration(
                hintStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  letterSpacing: -0.4,
                  color: AppColors.inputNameHint,
                ),
              ),
            ),
            20.verticalSpace,
            Row(
              children: [
                Text(
                  AppHelpers.getTranslation("Chiếc khấu"),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    letterSpacing: -0.4,
                    color: AppColors.black,
                  ),
                ),
                Expanded(
                  child: Text(
                    "${ticketline!.taxId}%",
                    textAlign: TextAlign.right,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      letterSpacing: -0.4,
                      color: AppColors.black,
                    ),
                  ),
                )
              ],
            ),
            20.verticalSpace,
            Row(
              children: [
                Text(
                  AppHelpers.getTranslation("Tổng tiền phát sinh"),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    letterSpacing: -0.4,
                    color: AppColors.black,
                  ),
                ),
                Expanded(
                  child: Text(
                    notifierPos.convertNumberZero(
                        double.parse(priceController.text) *
                            (int.parse("${ticketline!.taxId}") / 100) *
                            double.parse(unitController.text)),
                    textAlign: TextAlign.right,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      letterSpacing: -0.4,
                      color: AppColors.black,
                    ),
                  ),
                )
              ],
            ),
            20.verticalSpace,
            Row(
              children: [
                Text(
                  AppHelpers.getTranslation("Tổng tiền"),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    letterSpacing: -0.4,
                    color: AppColors.black,
                  ),
                ),
                Expanded(
                  child: Text(
                    notifierPos.convertNumberZero(
                        double.parse(priceController.text) *
                            (1 + int.parse("${ticketline!.taxId}") / 100) *
                            double.parse(unitController.text)),
                    textAlign: TextAlign.right,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      letterSpacing: -0.4,
                      color: AppColors.black,
                    ),
                  ),
                )
              ],
            ),
            50.verticalSpace,
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConfirmButton(
                    title: 'Đồng ý',
                    onTap: () {
                      notifierPos.editUnitProduct(
                          unitController.text,
                          priceController.text,
                          ticketline!.id,
                          ticketIndex,
                          ticketLineIndex);
                      Navigator.pop(context);
                    },
                  ),
                  ConfirmButton(
                    title: 'Hủy bỏ',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}
