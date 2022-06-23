import 'package:get/get.dart';

import '../controllers/bill_home_controller.dart';

class BillHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillHomeController>(
      () => BillHomeController(),
    );
  }
}
