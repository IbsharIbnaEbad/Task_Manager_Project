import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/models/task_list_model.dart';
import 'package:taskmanager/data/models/task_model.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/widgets/build_summery_section.dart';
import 'package:taskmanager/ui/widgets/center_circular_progress.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';
import 'package:taskmanager/ui/widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskListProgress = false;
  List<TaskModel> _newProgressList = [];

  @override
  void initState() {
    super.initState();
    _getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getProgressTaskList();
        },
        child: Column(
          children: [
            BuildSummerySection(),
            Expanded(
              child: Visibility(
                visible: !_getProgressTaskListProgress,
                replacement: const CenterCircularProgress(),
                child: ListView.separated(
                    itemCount: _newProgressList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskModel: _newProgressList[index],
                        onRefreshList: () {
                          _getProgressTaskList();
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 8,
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getProgressTaskList() async {
    _newProgressList.clear();
    _getProgressTaskListProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.ProgressTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _newProgressList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getProgressTaskListProgress = false;
    setState(() {});
  }
}
