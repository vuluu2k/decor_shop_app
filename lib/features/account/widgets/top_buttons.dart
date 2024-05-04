import 'package:flutter/material.dart';
import 'package:shop/features/account/widgets/account_button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          AccountButton(
            text: 'Hoá đơn',
            onTap: () {},
            icon: Icons.payment_outlined,
          ),
          AccountButton(
            text: 'Đổi mật khẩu',
            onTap: () {},
            icon: Icons.lock_outlined,
          ),
          AccountButton(
            text: 'Đăng xuất',
            onTap: () {},
            icon: Icons.logout_outlined,
          ),
        ],
      ),
    );
  }
}
