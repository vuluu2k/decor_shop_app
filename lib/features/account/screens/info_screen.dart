import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/common/widgets/custom_button.dart';
import 'package:shop/common/widgets/custom_textfield.dart';
import 'package:shop/constants/utils.dart';
import 'package:shop/features/auth/services/auth_service.dart';
import 'package:shop/providers/user_provider.dart';

class InfoScreen extends StatefulWidget {
  static const String routeName = '/info-screen';
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final AuthService authService = AuthService();
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  void updateUser() {
    authService.updateUser(
      context: context,
      name: _nameController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      onSuccess: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    _nameController.text = user.fullName;
    _emailController.text = user.email;
    _phoneController.text = user.sdt;
    _addressController.text = user.address;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _signUpFormKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _nameController,
                hintText: "Tên người dùng",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _emailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
                enabled: false,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _phoneController,
                hintText: "Số điện thoại",
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _addressController,
                hintText: "Địa chỉ",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: 'Cập nhật thông tin',
                onTap: () {
                  if (_signUpFormKey.currentState!.validate()) {
                    updateUser();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
