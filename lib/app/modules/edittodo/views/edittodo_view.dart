import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:simpletodoapp/app/modules/home/controllers/home_controller.dart';

import '../controllers/edittodo_controller.dart';

class EdittodoView extends GetView<EditTodoController> {
  final editTodoController = Get.find<EditTodoController>();
  final homeController = Get.find<HomeController>();
  EdittodoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EdittodoView'),
        centerTitle: true,
      ),
      body: Form(
          child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: editTodoController.title.toString(),
                onChanged: (title) {
                  editTodoController.title = title;
                },
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: editTodoController.description.toString(),
                onChanged: (description) {
                  editTodoController.description = description;
                },
                maxLines: null,
                decoration: const InputDecoration(labelText: 'Description'),
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
                        editTodoController.updateTodo();
                        Get.back();
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
