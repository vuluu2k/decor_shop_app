// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CountItem extends StatelessWidget {
  final int min;
  final int max;
  final int count;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  const CountItem({
    super.key,
    required this.count,
    required this.onDecrease,
    required this.onIncrease,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: const Border.symmetric(
          horizontal: BorderSide(color: Colors.black12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCountButton(
            Icons.remove_outlined,
            onDecrease,
            count != min,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              count.toString(),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          _buildCountButton(
            Icons.add_outlined,
            onIncrease,
            count != max,
          ),
        ],
      ),
    );
  }

  InkWell _buildCountButton(IconData icon, VoidCallback onTap,
      [bool active = true]) {
    return InkWell(
      onTap: !active ? null : onTap,
      child: Container(
        decoration: const BoxDecoration(
          border: Border.symmetric(
            vertical: BorderSide(color: Colors.black12),
          ),
        ),
        padding: const EdgeInsets.all(3),
        child: Icon(icon, color: active ? Colors.black : Colors.black12),
      ),
    );
  }
}
