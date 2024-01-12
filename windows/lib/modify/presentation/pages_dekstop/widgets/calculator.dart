import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../riverpob/providers/providers.dart';
import '../../theme/theme.dart';

class Calculator extends ConsumerStatefulWidget {
  final Function() onPayment;

  const Calculator({Key? key, required this.onPayment}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  ConsumerState<ConsumerStatefulWidget> createState() => _CalculatorState(onPayment: onPayment);
}

class _CalculatorState extends ConsumerState<Calculator> {
  final Function() onPayment;

  String inputText = "";
  String inputTextMod = "";
  bool multiMode = false;

  _CalculatorState({required this.onPayment});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final statePos = ref.watch(posSystemPASProvider);
    final notifierPos = ref.read(posSystemPASProvider.notifier);
    return Container(
      width: 240,
      height: 390,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText = "";
                      inputTextMod = "";
                      multiMode = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                        width: 130.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "CE",
                          style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (multiMode == false) {
                        inputTextMod = "X";
                        multiMode = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "*",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    var ticketlineSelected = statePos.listTicket![statePos.selectTicket!].ticketlines![statePos.selectTicketLine!];
                    if (ticketlineSelected.unit! - 1 > 0) {
                      notifierPos.editUnitProduct((ticketlineSelected.unit! - 1).toString(), ticketlineSelected.price.toString(), ticketlineSelected.productId, statePos.selectTicketLine!, statePos.selectTicket!);
                    } else {
                      notifierPos.deleteTicketline(statePos.selectTicket!, statePos.selectTicketLine!);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "-",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (multiMode) {
                                inputTextMod += "7";
                              } else {
                                inputText += "7";
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                            child: Container(
                                width: 60.r,
                                height: 60.r,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.green.withOpacity(0.1),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "7",
                                  style: TextStyle(fontSize: 30, color: Colors.green),
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (multiMode) {
                                inputTextMod += "8";
                              } else {
                                inputText += "8";
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                            child: Container(
                                width: 60.r,
                                height: 60.r,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.green.withOpacity(0.1),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "8",
                                  style: TextStyle(fontSize: 30, color: Colors.green),
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (multiMode) {
                                inputTextMod += "9";
                              } else {
                                inputText += "9";
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                            child: Container(
                                width: 60.r,
                                height: 60.r,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.green.withOpacity(0.1),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "9",
                                  style: TextStyle(fontSize: 30, color: Colors.green),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (multiMode) {
                                inputTextMod += "4";
                              } else {
                                inputText += "4";
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                            child: Container(
                                width: 60.r,
                                height: 60.r,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.green.withOpacity(0.1),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "4",
                                  style: TextStyle(fontSize: 30, color: Colors.green),
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (multiMode) {
                                inputTextMod += "5";
                              } else {
                                inputText += "5";
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                            child: Container(
                                width: 60.r,
                                height: 60.r,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.green.withOpacity(0.1),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "5",
                                  style: TextStyle(fontSize: 30, color: Colors.green),
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (multiMode) {
                                inputTextMod += "6";
                              } else {
                                inputText += "6";
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                            child: Container(
                                width: 60.r,
                                height: 60.r,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.green.withOpacity(0.1),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "6",
                                  style: TextStyle(fontSize: 30, color: Colors.green),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    var ticketlineSelected = statePos.listTicket![statePos.selectTicket!].ticketlines![statePos.selectTicketLine!];
                    notifierPos.editUnitProduct((ticketlineSelected.unit! + 1).toString(), ticketlineSelected.price.toString(), ticketlineSelected.productId, statePos.selectTicketLine!, statePos.selectTicket!);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                        width: 60.r,
                        height: 130.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "+",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (multiMode) {
                                inputTextMod += "1";
                              } else {
                                inputText += "1";
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                            child: Container(
                                width: 60.r,
                                height: 60.r,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.green.withOpacity(0.1),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "1",
                                  style: TextStyle(fontSize: 30, color: Colors.green),
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (multiMode) {
                                inputTextMod += "2";
                              } else {
                                inputText += "2";
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                            child: Container(
                                width: 60.r,
                                height: 60.r,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.green.withOpacity(0.1),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "2",
                                  style: TextStyle(fontSize: 30, color: Colors.green),
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (multiMode) {
                                inputTextMod += "3";
                              } else {
                                inputText += "3";
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                            child: Container(
                                width: 60.r,
                                height: 60.r,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.green.withOpacity(0.1),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "3",
                                  style: TextStyle(fontSize: 30, color: Colors.green),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (multiMode) {
                                inputTextMod += "0";
                              } else {
                                inputText += "0";
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                            child: Container(
                                width: 130.r,
                                height: 60.r,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.green.withOpacity(0.1),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "0",
                                  style: TextStyle(fontSize: 30, color: Colors.green),
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (multiMode) {
                              inputTextMod += ".";
                            } else {
                              inputText += ".";
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                            child: Container(
                                width: 60.r,
                                height: 60.r,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.green.withOpacity(0.1),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  ".",
                                  style: TextStyle(fontSize: 30, color: Colors.green),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                statePos.listTicket!.isNotEmpty
                    ? InkWell(
                        onTap: (statePos.listTicket![statePos.selectTicket!].ticketlines!.isNotEmpty && !statePos.createTicketLoading!) ? onPayment : () {},
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Container(
                              width: 60.r,
                              height: 130.r,
                              decoration: BoxDecoration(
                                border: Border.all(color: notifierPos.listTicket.isNotEmpty ? (notifierPos.listTicket[statePos.selectTicket!].ticketlines!.isNotEmpty ? Colors.green : Colors.grey) : Colors.grey.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(5.r),
                                color: notifierPos.listTicket.isNotEmpty ? (notifierPos.listTicket[statePos.selectTicket!].ticketlines!.isNotEmpty ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1)) : Colors.grey.withOpacity(0.1),
                              ),
                              alignment: Alignment.center,
                              child: statePos.createTicketLoading!
                                  ? const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.greenMain,
                                    )
                                  : Text(
                                      "=",
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: notifierPos.listTicket.isNotEmpty ? (notifierPos.listTicket[statePos.selectTicket!].ticketlines!.isNotEmpty ? Colors.green : Colors.grey) : Colors.grey.withOpacity(0.1),
                                      ),
                                    )),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.mainBack,
                          strokeWidth: 2,
                        ),
                      ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      width: 130.r,
                      height: 57.r,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(5.r),
                        color: Colors.green.withOpacity(0.1),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(inputText)],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      width: 60.r,
                      height: 57.r,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        color: Colors.green.withOpacity(0.1),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(inputTextMod)],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      width: 60.r,
                      height: 57.r,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(5.r),
                        color: Colors.green.withOpacity(0.1),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        FlutterRemix.barcode_line,
                        size: 20.r,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
