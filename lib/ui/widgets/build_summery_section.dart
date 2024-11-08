import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/task_status_count_model.dart';

import 'package:taskmanager/data/models/task_status_model.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';
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
  bool _getTaskStatusCountListProgress = false;

  @override
  void initState() {
    super.initState();

    _getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: !_getTaskStatusCountListProgress,
        replacement: CenterCircularProgress(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _getTaskSummaryCardList(),
          ),
        ),
      ),
    );
  }

  Future<void> _getTaskStatusCount() async {
    _taskStatusCountList.clear();
    _getTaskStatusCountListProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskStatusCount);
    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel =
          TaskStatusCountModel.fromJson(response.responseData);
      _taskStatusCountList = taskStatusCountModel.taskStatusCountList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getTaskStatusCountListProgress = false;
    setState(() {});
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
