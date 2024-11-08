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

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  bool _getCompleteTasklistProgress = false;
  List<TaskModel> _completedTaskList = [];

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
            BuildSummerySection(),

            Expanded(
              child: Visibility(
                visible: !_getCompleteTasklistProgress,
                replacement: const CenterCircularProgress(),
                child: ListView.separated(
                    itemCount: _completedTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskModel: _completedTaskList[index],
                        onRefreshList: _getCompleteTasklist,
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

  Future<void> _getCompleteTasklist() async {
    _completedTaskList.clear();
    _getCompleteTasklistProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.CompletedTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _completedTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getCompleteTasklistProgress = false;
    setState(() {});
  }
}
