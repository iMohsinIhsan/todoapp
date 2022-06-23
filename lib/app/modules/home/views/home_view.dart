import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:simpletodoapp/app/data/model/todo_model.dart';
import 'package:simpletodoapp/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';
import 'widgets/swiper_todo_card.dart';

class HomeView extends GetView<HomeController> {
  HomeController homeController = Get.find();

  var selectedTab = 1.obs;

  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60.h,
              width: 375.w,
              color: Colors.blue,
              child: Row(
                children: [
                  SizedBox(
                    width: 20.w,
                    child: Icon(
                      Icons.list,
                      size: 30.w,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Todo App',
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                ],
              ),
            ),
            Obx(() => selectedTab.value == 1
                ? TodosTab(homeController: homeController)
                : CompletedTab(homeController: homeController)),
            Container(
              width: 375.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Obx(
                        () => TextButton(
                          style: TextButton.styleFrom(
                              primary: selectedTab == 2
                                  ? Colors.black54
                                  : Colors.black),
                          onPressed: () {
                            selectedTab.value = 1;
                          },
                          child: Text(
                            'Todos',
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                    height: 0.05.sh,
                    child: Container(
                      color: Colors.blue.shade200,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Obx(
                        () => TextButton(
                          style: TextButton.styleFrom(
                              primary: selectedTab == 1
                                  ? Colors.black54
                                  : Colors.black),
                          onPressed: () {
                            selectedTab.value = 2;
                          },
                          child: Text(
                            'Completed',
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompletedTab extends StatelessWidget {
  const CompletedTab({
    Key? key,
    required this.homeController,
  }) : super(key: key);

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Obx(
      () => homeController.completedTodos.isEmpty
          ? const Center(
              child: Text('No Completed Todos...'),
            )
          : ListView.builder(
              itemCount: homeController.completedTodos.length,
              itemBuilder: (context, index) {
                Todo todo = homeController.completedTodos[index];
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.blue.shade50,
                        child: Row(
                          children: [
                            Checkbox(
                                value: todo.isComplete,
                                onChanged: (value) {
                                  homeController.toggleTodoState(todo);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Task marked incompleted',
                                        textAlign: TextAlign.center,
                                      ),
                                      duration: Duration(seconds: 1),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                    ),
                                  );
                                }),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      todo.title,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.blue.shade700,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  todo.description != null
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(todo.description!),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.EDITTODO,
                                        arguments: todo);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blue.shade600,
                                    size: 25.r,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    homeController.removeTodo(todo);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 30.r,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    ));
  }
}

class TodosTab extends StatelessWidget {
  TodosTab({
    Key? key,
    required this.homeController,
  }) : super(key: key);

  final HomeController homeController;
  var isLeftSwipe = false.obs;
  // double _width = 1.sw;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Obx(
            () => homeController.todos.isEmpty
                ? const Center(
                    child: Text('No Todos...'),
                  )
                : ListView.builder(
                    itemCount: homeController.todos.length,
                    itemBuilder: (context, index) {
                      Todo todo = homeController.todos[index];
                      return SwiperTodoCard(
                        todo: todo,
                        height: 140.h,
                        onRemove: () {
                          homeController.removeTodo(todo);
                        },
                        onTodoComplete: (value) {
                          homeController.toggleTodoState(todo);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Task Completed',
                                textAlign: TextAlign.center,
                              ),
                              duration: Duration(seconds: 1),
                              padding: EdgeInsets.symmetric(vertical: 20),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Add Todo'),
                      content: Form(
                          child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: homeController.titleController,
                                decoration: const InputDecoration(
                                  labelText: 'Title',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller:
                                    homeController.descriptionController,
                                maxLines: null,
                                decoration: const InputDecoration(
                                    labelText: 'Description'),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: double.maxFinite,
                                height: 40.h,
                                child: Container(
                                  color: Colors.blue,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        homeController.addTodo();
                                        Get.back();
                                      },
                                      child: const Text(
                                        "Add",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                    );
                  }),
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
