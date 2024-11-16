import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/data/models/task_status_model.dart';
import 'package:taskmanager/ui/controller/task_list_count_controller.dart';
import 'package:taskmanager/ui/widgets/center_circular_progress.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';
import 'package:taskmanager/ui/widgets/task_summery_screen.dart';

class BuildSummerySection extends StatefulWidget {
  const BuildSummerySection({super.key});

  @override
  State<BuildSummerySection> createState() => _BuildSummerySectionState();
}

class _BuildSummerySectionState extends State<BuildSummerySection> {

  List<TaskStatusModel> _taskStatusCountList = [];

  final TaskListCountController _taskListCountController = Get.find<TaskListCountController>();

  @override
  void initState() {
    super.initState();
    _getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<TaskListCountController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.inprogress,
            replacement: const CenterCircularProgress(),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _getTaskSummaryCardList(),
              ),
            ),
          );
        }
      ),
    );
  }

  Future<void> _getTaskStatusCount() async {
   // _taskStatusCountList.clear();
    final bool result = await _taskListCountController.getTaskStatusCount();
    if (result) {
      setState(() {
        _taskStatusCountList = _taskListCountController.taskList;
      });
    } else {
      showSnackBarMessage(context, _taskListCountController.errorMessage!, true);
    }
  }

  List<TaskSummeryCard> _getTaskSummaryCardList() {
    List<TaskSummeryCard> taskSummeryCardList = [];
    for (TaskStatusModel t in _taskStatusCountList) {
      taskSummeryCardList
          .add(TaskSummeryCard(title: t.sId!, count: t.sum ?? 0));
    }
    return taskSummeryCardList;
  }
}
