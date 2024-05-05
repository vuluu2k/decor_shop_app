import 'package:flutter/material.dart';
import 'package:shop/common/widgets/custom_button.dart';
import 'package:shop/common/widgets/custom_textfield.dart';
import 'package:shop/features/account/widgets/account_button.dart';
import 'package:shop/features/auth/services/auth_service.dart';
import 'package:shop/features/bill/screen/bill_screen.dart';
import 'package:shop/features/cart/screens/cart_screen.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController rePasswordController = TextEditingController();

    final changePasswordForm = GlobalKey<FormState>();
    final AuthService authService = AuthService();
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          AccountButton(
            text: 'Thông tin cá nhân',
            onTap: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
            icon: Icons.info_outlined,
          ),
          AccountButton(
            text: 'Giỏ hàng',
            onTap: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
            icon: Icons.shopping_cart_outlined,
          ),
          AccountButton(
            text: 'Hoá đơn',
            onTap: () {
              Navigator.pushNamed(context, BillScreen.routeName);
            },
            icon: Icons.payment_outlined,
          ),
          AccountButton(
            text: 'Đổi mật khẩu',
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
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
                            key: changePasswordForm,
                            child: Column(
                              children: [
                                CustomTextField(
                                  controller: passwordController,
                                  hintText: "Mật khẩu mới",
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  controller: rePasswordController,
                                  hintText: "Xác nhận mật khẩu mới",
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                ),
                                const SizedBox(height: 10),
                                CustomButton(
                                  text: 'Đổi mật khẩu',
                                  onTap: () {
                                    if (changePasswordForm.currentState!
                                        .validate()) {
                                      authService.changePassword(
                                        context: context,
                                        password: passwordController.text,
                                        rePassword: rePasswordController.text,
                                        onSuccess: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    }
                                  },
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
