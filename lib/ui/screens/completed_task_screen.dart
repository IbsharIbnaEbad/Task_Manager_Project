import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/controller/completed_task_controller.dart';
import 'package:taskmanager/ui/widgets/build_summery_section.dart';
import 'package:taskmanager/ui/widgets/center_circular_progress.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';
import 'package:taskmanager/ui/widgets/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  final CompletedTaskController _completedTaskController =
      Get.find<CompletedTaskController>();

  @override
  void initState() {
    super.initState();
    _getCompleteTasklist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getCompleteTasklist();
        },
        child: Column(
          children: [
            const BuildSummerySection(),
            Expanded(
              child: GetBuilder<CompletedTaskController>(
                builder: (controller) {
                  return Visibility(
                    visible: !controller.inprogress,
                    replacement: const CenterCircularProgress(),
                    child: ListView.separated(
                      itemCount: controller.taskList.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          taskModel: controller.taskList[index],
                          onRefreshList: _getCompleteTasklist,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getCompleteTasklist() async {
    final bool result = await _completedTaskController.getCompleteTasklist();
    if (result == false) {
      showSnackBarMessage(
          context, _completedTaskController.errorMessage!, true);
    }
  }
}
