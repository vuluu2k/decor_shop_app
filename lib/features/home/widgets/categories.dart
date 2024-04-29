import 'package:flutter/material.dart';
import 'package:shop/constants/global_variables.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVariables.carouselImages.length,
        itemExtent: 75,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    GlobalVariables.categoryImages[index]["image"]!,
                    fit: BoxFit.cover,
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
              Text(
                GlobalVariables.categoryImages[index]["title"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
