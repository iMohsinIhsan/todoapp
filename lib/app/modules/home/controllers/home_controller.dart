import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpletodoapp/app/data/model/todo_model.dart';
import 'package:simpletodoapp/app/modules/edittodo/controllers/edittodo_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final _todos = <Todo>[
    Todo(title: 'Buy some food1', description: '''
    -Apple1
    -Mangoes
    -Bananas'''),
    Todo(title: 'Buy some food2', description: '''
    -Apple2
    -Mangoes
    -Bananas'''),
    Todo(title: 'Buy some food3', description: '''
    -Apple3
    -Mangoes
    -Bananas'''),
    Todo(title: 'Buy some food4', description: '''
    -Apple4
    -Mangoes
    -Bananas'''),
  ].obs;

  List<Todo> get todos =>
      _todos.where((todo) => todo.isComplete == false).toList();
  List<Todo> get completedTodos =>
      _todos.where((todo) => todo.isComplete == true).toList();

  void addTodo() {
    Todo todo = Todo(
        title: titleController.text, description: descriptionController.text);
    _todos.add(todo);
    titleController.clear();
    descriptionController.clear();
  }

  void todosRefresh() {
    _todos.refresh();
  }

  void removeTodo(todo) {
    _todos.remove(todo);
    print("Todo Removed:");
    print(todo.title);
    _todos.refresh();
  }

  void toggleTodoState(Todo todo) {
    todo.isComplete = !todo.isComplete;
    _todos.refresh();
  }

  @override
  void onInit() {
    super.onInit();
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
