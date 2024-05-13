import 'package:flutter/material.dart';
import 'package:shop/common/widgets/custom_button.dart';
import 'package:shop/common/widgets/custom_textfield.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/features/auth/services/auth_service.dart';

enum Auth { signin, signup, forgot }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signin;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final _forgotFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void clearState() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _addressController.clear();
    _passwordController.clear();
    _rePasswordController.clear();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      rePassword: _rePasswordController.text,
      onSuccess: () {
        setState(() {
          _auth = Auth.signin;
        });

        clearState();
      },
    );
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  void forgotPassword() {
    authService.forgotPassword(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      rePassword: _rePasswordController.text,
      onSuccess: () {
        setState(() {
          _auth = Auth.signin;
        });

        clearState();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: const Text(
                        'Decor Shop',
                        style: TextStyle(
                          color: GlobalVariables.selectedNavBarColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    if (_auth == Auth.signup)
                      Container(
                        padding: const EdgeInsets.all(8),
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
                              CustomTextField(
                                controller: _passwordController,
                                hintText: "Mật khẩu",
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: _rePasswordController,
                                hintText: "Nhập lại mật khẩu",
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                              ),
                              const SizedBox(height: 10),
                              CustomButton(
                                text: 'Đăng ký',
                                onTap: () {
                                  if (_signUpFormKey.currentState!.validate()) {
                                    signUpUser();
                                  }
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Bạn đã có tài khoản?'),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _auth = Auth.signin;
                                      });
                                    },
                                    child: Text('Đăng nhập'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (_auth == Auth.signin)
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Form(
                          key: _signInFormKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: _emailController,
                                hintText: "Email",
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: _passwordController,
                                hintText: "Mật khẩu",
                                obscureText: true,
                              ),
                              const SizedBox(height: 10),
                              CustomButton(
                                text: 'Đăng nhập',
                                onTap: () {
                                  if (_signInFormKey.currentState!.validate()) {
                                    signInUser();
                                  }
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Bạn chưa có tài khoản?'),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _auth = Auth.signup;
                                      });
                                    },
                                    child: Text('Đăng ký'),
                                  )
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _auth = Auth.forgot;
                                  });
                                },
                                child: const Text('Quên mật khẩu?'),
                              )
                            ],
                          ),
                        ),
                      ),
                    if (_auth == Auth.forgot)
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Form(
                          key: _forgotFormKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: _emailController,
                                hintText: "Email",
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: _passwordController,
                                hintText: "Mật khẩu mới",
                                obscureText: true,
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: _rePasswordController,
                                hintText: "Nhập lại mật khẩu",
                                obscureText: true,
                              ),
                              const SizedBox(height: 10),
                              CustomButton(
                                text: 'Lấy lại mật khẩu',
                                onTap: () {
                                  if (_forgotFormKey.currentState!.validate()) {
                                    forgotPassword();
                                  }
                                },
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                child: const Text('Quay lại'),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _auth = Auth.signin;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
