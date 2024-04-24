import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/common/widgets/custom_button.dart';
import 'package:shop/common/widgets/custom_textfield.dart';
import 'package:shop/constants/global_variables.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Navigator.pushNamed(context, 'Test');
    return Scaffold(
        backgroundColor: GlobalVariables.greyBackgroundCOlor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Xin chào",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
                ListTile(
                  tileColor: _auth == Auth.signup
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: const Text('Tạo tài khoản mới',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? value) {
                      setState(() {
                        _auth = value!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signup)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                        key: _signInFormKey,
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
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: "Mật khẩu",
                            ),
                            const SizedBox(height: 10),
                            CustomButton(text: 'Tạo tài khoản', onTap: () {})
                          ],
                        )),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signin
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: const Text('Đăng nhập',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? value) {
                      setState(() {
                        _auth = value!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signin)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                        key: _signInFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _nameController,
                              hintText: "Tên người dùng",
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: "Mật khẩu",
                            ),
                            const SizedBox(height: 10),
                            CustomButton(text: 'Tạo tài khoản', onTap: () {})
                          ],
                        )),
                  ),
              ],
            ),
          ),
        ));
  }
}
