import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/common/widgets/product_list.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/features/home/widgets/carousels.dart';
import 'package:shop/features/home/widgets/categories.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/product_provider.dart';
import 'package:shop/providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    const borderSearchRadius = 4.0;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 36,
                  child: Material(
                    borderRadius: BorderRadius.circular(borderSearchRadius),
                    elevation: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(borderSearchRadius),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Tìm kiếm',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: const Badge(
                  backgroundColor: Color.fromARGB(255, 238, 77, 45),
                  label: Text('1'),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.av_timer,
                  color: Colors.white,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Carousels(),
            Categories(),
            SizedBox(height: 10),
            ProductList(),
          ],
        ),
      ),
    );
  }
}
