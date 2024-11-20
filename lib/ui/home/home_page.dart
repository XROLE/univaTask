import 'package:flutter/material.dart';
import 'package:univa_task/app/core/di/service_locator.dart';
import 'package:univa_task/data/remote/task_service.dart';
import 'package:univa_task/ui/base/base_view.dart';
import 'package:univa_task/ui/home/home_view_model.dart';
import 'package:univa_task/ui/widgets/task_widget.dart';
import 'package:univa_task/utils/app_flushbar.dart';
import 'package:univa_task/utils/app_text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BaseView<HomeViewModel>(
        model: HomeViewModel(sl.get<TaskService>()),
        onModelReady: (model) {
          model.fetchTasks(onError: (errorMessage) {
            AppFlushBar.showError(message: errorMessage, context: context);
          });
        },
        builder: (context, model, _) {
          return Scaffold(
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * .04),
              height: size.height,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tasks", style: AppTextStyle.title()),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
                    ],
                  ),
                  if (model.tasks.isNotEmpty)
                    ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: size.height * .02),
                      shrinkWrap: true,
                        itemCount: model.tasks.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              TaskWidget(task: model.tasks[index]),
                              if(index != model.tasks.length - 1)
                              const Divider()
                            ],
                          );
                        }),
                ],
              ),
            ),
          );
        });
  }
}
