import 'package:get/get.dart';
import 'package:simpletodoapp/app/data/model/todo_model.dart';
import 'package:simpletodoapp/app/modules/home/controllers/home_controller.dart';

class EditTodoController extends GetxController {
  //TODO: Implement EditTodoController

  final homeController = Get.find<HomeController>();
  String title = '';
  String description = '';
  var todo = Get.arguments;

  void updateTodo() {
    todo.title = title;
    todo.description = description;
    homeController.todosRefresh();
  }

  @override
  void onInit() {
    super.onInit();
    title = todo.title;
    description = todo.description!;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
