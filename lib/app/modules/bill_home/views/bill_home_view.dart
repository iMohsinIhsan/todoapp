import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bill_home_controller.dart';

class BillHomeView extends GetView<BillHomeController> {
  const BillHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BillHomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BillHomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
