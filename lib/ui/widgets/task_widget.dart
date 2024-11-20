import 'package:flutter/material.dart';
import 'package:univa_task/data/model/task_model.dart';
import 'package:univa_task/utils/app_colors.dart';
import 'package:univa_task/utils/app_text_style.dart';
import 'package:univa_task/utils/constants/constants.dart';
import 'package:univa_task/utils/helper.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  const TaskWidget({required this.task, super.key});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late bool isCompleted;
  @override
  void initState() {
    isCompleted = widget.task.completed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double squareLength = size.width * .13;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      leading: Container(
        height: squareLength,
        width: squareLength,
        decoration: BoxDecoration(
            color: Helper().getRandomColor(),
            borderRadius: BorderRadius.circular(squareLength)),
        child: Center(
            child: Text(
          "T${widget.task.id}",
          style: AppTextStyle.subTitle(color: AppColors.white),
        )),
      ),
      title: Text(
        widget.task.title,
        style: AppTextStyle.subTitle(decoration: isCompleted ? TextDecoration.lineThrough : null),
      ),
      subtitle: Text(
        isCompleted ? Constants.completed : Constants.notCompleted,
        style: AppTextStyle.medium(decoration: isCompleted ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        value: isCompleted,
        onChanged: (val) {
          setState(() {
            isCompleted = !isCompleted;
          });
        },
      ),
    );
  }
}
