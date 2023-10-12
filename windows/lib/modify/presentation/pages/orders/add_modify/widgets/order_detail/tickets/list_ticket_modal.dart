import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/presentation/components/buttons/ticket_item.dart';
import 'package:g_manager_app/modify/riverpob/providers/customers/customer_provider.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';

import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';

class ListTicketModal extends ConsumerStatefulWidget {
  const ListTicketModal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListTicketModalState();
}

class _ListTicketModalState extends ConsumerState<ListTicketModal> {
  int selectTicket = 0;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(posSystemPASProvider);
    final notifier = ref.read(posSystemPASProvider.notifier);
    final stateCustomer = ref.watch(customersProvider);
    final notifierCustomer = ref.watch(customersProvider.notifier);
    return Material(
      color: AppColors.mainBackground,
      child: Container(
        padding: REdgeInsets.only(
          top: 20,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Stack(
          children: [
            ListView.builder(
              padding: REdgeInsets.symmetric(vertical: 10),
              physics: const CustomBouncingScrollPhysics(),
              itemCount: state.listTicket!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final ticket = state.listTicket![index];
                return TicketItem(
                  title: "${ticket.title}"
                      "\n ${notifierCustomer.getNameCustomeById(ticket.customerId!)}",
                  isSelected: index == selectTicket ? true : false,
                  onDelete: () {
                    print(index);
                    notifier.deleteTicket(index);
                    notifier.updateIndex("ticket", state.listTicket!.length - 1);
                  },
                  onTap: () {
                    setState(() {
                      selectTicket = index;
                      var customerPos = ["", "Khách lẻ", "Không có địa chỉ cụ thể", "", ""];
                      if (state.listTicket![index].customerId != "") {
                        var customer = stateCustomer.customers!.where((c) => c.id == state.listTicket![index].customerId!).toList()[0];
                        customerPos = [customer.id!, customer.name!, customer.address!, customer.fileOrdersId ?? "", customer.taxCategory!];
                      }
                      notifier.setSelectUserPos(customerPos);
                      notifierCustomer.selectCustomer(state.infoSelected![0][0]);
                      notifier.updateIndex("ticket", index);
                      context.popRoute();
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
