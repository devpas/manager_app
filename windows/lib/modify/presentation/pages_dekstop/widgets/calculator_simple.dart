import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../riverpob/providers/providers.dart';
import '../../theme/theme.dart';

class CalculatorSimple extends ConsumerStatefulWidget {
  final Function() onPayment;

  const CalculatorSimple({Key? key, required this.onPayment}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  ConsumerState<ConsumerStatefulWidget> createState() => _CalculatorSimpleState(onPayment: onPayment);
}

class _CalculatorSimpleState extends ConsumerState<CalculatorSimple> {
  final Function() onPayment;

  String inputText = "";
  String inputTextMod = "";
  bool multiMode = false;

  _CalculatorSimpleState({required this.onPayment});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final statePos = ref.watch(posSystemPASProvider);
    final notifierPos = ref.read(posSystemPASProvider.notifier);
    return Container(
      width: 185,
      height: 350,
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
                          "-",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
              ],
            ),
            Row(
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
            Row(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
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
                      child: Icon(
                        FlutterRemix.check_line,
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