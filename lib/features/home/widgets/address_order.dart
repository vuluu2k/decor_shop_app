import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/providers/user_provider.dart';

class AddressOrder extends StatelessWidget {
  const AddressOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: GlobalVariables.addressGradient,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Icon(Icons.location_on),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Vận chuyển tới ${user.name} - ${user.address}',
                style: const TextStyle(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5, top: 2),
            child: Icon(Icons.arrow_drop_down),
          )
        ],
      ),
    );
  }
}
