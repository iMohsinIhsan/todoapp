import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simpletodoapp/app/data/model/todo_model.dart';

import '../../../../routes/app_pages.dart';

class SwiperTodoCard extends StatefulWidget {
  final double height;
  final VoidCallback onRemove;
  final Todo todo;
  final void Function(bool?)? onTodoComplete;

  SwiperTodoCard({
    required this.todo,
    required this.height,
    required this.onRemove,
    required this.onTodoComplete,
  });

  @override
  State<SwiperTodoCard> createState() => _SwiperTodoCardState();
}

class _SwiperTodoCardState extends State<SwiperTodoCard> {
  var isLeftSwipe = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0.r),
      child: SizedBox(
        height: widget.height,
        // width: _width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 12.0.w),
                child: IconButton(
                  onPressed: widget.onRemove,
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30.r,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              width: 375.w,
              right: isLeftSwipe ? -80.w : 0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              // left: 20,
              child: GestureDetector(
                onHorizontalDragEnd: (DragEndDetails drag) {
                  if (drag.primaryVelocity == null) return;
                  if (drag.primaryVelocity! < 0) {
                    setState(() {
                      isLeftSwipe = true;
                    });
                  } else {
                    setState(() {
                      isLeftSwipe = false;
                    });
                  }
                },
                child: SizedBox(
                  height: widget.height,
                  child: Card(
                    color: Colors.blue.shade50,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: widget.todo.isComplete,
                          onChanged: widget.onTodoComplete,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.todo.title,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.blue.shade700,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              widget.todo.description != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(widget.todo.description!),
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
                                    arguments: widget.todo);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue.shade600,
                                size: 25.r,
                              ),
                            ),
                            // IconButton(
                            //   onPressed: () {
                            //     homeController.removeTodo(todo);
                            //   },
                            //   icon: Icon(
                            //     Icons.delete,
                            //     color: Colors.red,
                            //     size: 30.r,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
