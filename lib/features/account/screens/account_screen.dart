import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/features/account/widgets/orders.dart';
import 'package:shop/features/account/widgets/top_buttons.dart';
import 'package:shop/providers/user_provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child:
                      Text(user.fullName, style: const TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ),
        body: const Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TopButtons(),
            SizedBox(
              height: 20,
            ),
            Orders()
          ],
        ));
  }
}
