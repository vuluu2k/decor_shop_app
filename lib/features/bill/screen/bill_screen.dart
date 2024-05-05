import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/features/bill/services/bill_service.dart';
import 'package:shop/providers/bill_provider.dart';

class BillScreen extends StatefulWidget {
  static const String routeName = '/bill-screen';
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  final BillService billService = BillService();

  @override
  void initState() {
    super.initState();
    billService.getBills(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final bills = Provider.of<BillProvider>(context).bills;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoá đơn'),
      ),
      body: bills.content.isEmpty
          ? const Center(
              child: Text(
                'Bạn chưa có hoá đơn!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : Container(
              child: ListView.builder(
                itemCount: bills.content.length,
                itemBuilder: (context, index) {
                  final bill = bills.content[index];

                  return InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          color: Colors.black26,
                          width: 1,
                        )),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tổng tiền: ₫${bill.total}',
                                style: const TextStyle(
                                  color: GlobalVariables.selectedNavBarColor,
                                ),
                              ),
                              Text(
                                'Tạo lúc: ${DateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(bill.createdDate))}',
                              ),
                            ],
                          ),
                          Text('Phương thức: Thanh toán khi nhận hàng'),
                          Text('Giao tới: ${bill.address}')
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
