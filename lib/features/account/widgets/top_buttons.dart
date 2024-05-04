import 'package:flutter/material.dart';
import 'package:shop/common/widgets/custom_button.dart';
import 'package:shop/common/widgets/custom_textfield.dart';
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
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  final TextEditingController _passwordController =
                      TextEditingController();
                  final TextEditingController _rePasswordController =
                      TextEditingController();

                  return StatefulBuilder(builder: (context, setState) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Text(
                              'Thay đổi mật khẩu',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Form(
                            child: Column(
                              children: [
                                CustomTextField(
                                  controller: _passwordController,
                                  hintText: "Mật khẩu mới",
                                  obscureText: true,
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  controller: _rePasswordController,
                                  hintText: "Xác nhận mật khẩu mới",
                                  obscureText: true,
                                ),
                                const SizedBox(height: 10),
                                CustomButton(
                                  text: 'Đổi mật khẩu',
                                  onTap: () {},
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
                },
              );
            },
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
