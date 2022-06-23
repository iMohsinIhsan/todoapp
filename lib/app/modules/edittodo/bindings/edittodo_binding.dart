import 'package:get/get.dart';

import '../controllers/edittodo_controller.dart';

class EdittodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditTodoController>(
      () => EditTodoController(),
    );
  }
}
