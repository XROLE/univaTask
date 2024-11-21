import 'package:flutter/material.dart';
import 'package:univa_task/app/core/di/service_locator.dart';
import 'package:univa_task/data/local/task_service.dart';
import 'package:univa_task/data/model/task_model.dart';
import 'package:univa_task/data/remote/task_service.dart';
import 'package:univa_task/ui/auth/auth_page.dart';
import 'package:univa_task/ui/base/base_view.dart';
import 'package:univa_task/ui/home/home_view_model.dart';
import 'package:univa_task/ui/widgets/action_button.dart';
import 'package:univa_task/ui/widgets/task_widget.dart';
import 'package:univa_task/utils/app_colors.dart';
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
        model: HomeViewModel(
          taskCacheService: sl.get<TaskCacheService>(),
          taskService: sl.get<TaskService>(),
        ),
        onModelReady: (model) async {
          List<Task> tasksFromCache = await model.loadCachedTasks();
          model.tasks = tasksFromCache;
          model.fetchTasks(
              onError: (errorMessage) {
                AppFlushBar.showError(message: errorMessage, context: context);
              },
              onSuccess: (tasks) => model.cachedTasks(tasks));
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
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Logout",
                                              textAlign: TextAlign.start,
                                              style: AppTextStyle.title(
                                                  fontSize: 22),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        Text(
                                          "Are you sure you want to log out?",
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.subTitle(
                                              fontweight: FontWeight.w400,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: ActionButton(
                                                  title: "Canceal",
                                                  bgColor: AppColors.green
                                                      .withOpacity(.8),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  }),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: ActionButton(
                                                  title: "Continue",
                                                  bgColor: AppColors.red,
                                                  onTap: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const AuthPage()));
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          icon: const Icon(Icons.menu))
                    ],
                  ),
                  model.tasks.isEmpty 
                  ? SizedBox(
                    height: size.height * .6,
                    child: Center(child: Text("No task at the moment. \n Kindly create a new task to get started", style: AppTextStyle.medium(), textAlign: TextAlign.center,),))
                   : RefreshIndicator(
                      onRefresh: () async {
                        model.fetchTasks(
                            onError: (errorMessage) {
                              AppFlushBar.showError(
                                  message: errorMessage, context: context);
                            },
                            onSuccess: (tasks) => model.cachedTasks(tasks));
                      },
                      child: SizedBox(
                        height: size.height * .82,
                        child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * .02),
                            shrinkWrap: true,
                            itemCount: model.tasks.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  TaskWidget(task: model.tasks[index]),
                                  if (index != model.tasks.length - 1)
                                    const Divider()
                                ],
                              );
                            }),
                      ),
                    ),
                ],
              ),
            ),
          );
        });
  }
}
