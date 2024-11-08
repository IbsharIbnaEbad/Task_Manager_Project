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

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskListProgress = false;
  List<TaskModel> _cancelledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getCancelledTaskList();
        },
        child: Column(
          children: [
            BuildSummerySection(),
            Expanded(
              child: Visibility(
                visible: !_getCancelledTaskListProgress,
                replacement: const CenterCircularProgress(),
                child: ListView.separated(
                    itemCount: _cancelledTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskModel: _cancelledTaskList[index],
                        onRefreshList: () {
                          _cancelledTaskList;
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

  Future<void> _getCancelledTaskList() async {
    _cancelledTaskList.clear();
    _getCancelledTaskListProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.CencelledTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _cancelledTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getCancelledTaskListProgress = false;
    setState(() {});
  }
}
