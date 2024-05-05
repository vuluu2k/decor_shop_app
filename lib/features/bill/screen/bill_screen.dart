import 'package:flutter/material.dart';

class BillScreen extends StatefulWidget {
  static const String routeName = '/bill-screen';
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text('Bill'),
    ));
  }
}
