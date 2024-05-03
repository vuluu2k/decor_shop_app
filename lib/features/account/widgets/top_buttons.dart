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
            AccountButton(text: 'Đổi mật khẩu', onTap: () {}),
            AccountButton(text: 'Đăng xuất', onTap: () {}),
          ],
        ),
      ],
    );
  }
}
