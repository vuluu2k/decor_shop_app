import 'package:flutter/material.dart';
import 'package:shop/features/account/widgets/account_button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Đơn hàng', onTap: () {}),
            AccountButton(text: 'Ưu thích', onTap: () {}),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(children: [
          AccountButton(text: 'Ưu thích', onTap: () {}),
          AccountButton(text: 'Đăng xuất', onTap: () {}),
        ])
      ],
    );
  }
}
