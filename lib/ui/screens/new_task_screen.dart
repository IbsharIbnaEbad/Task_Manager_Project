import 'package:flutter/material.dart';

import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/task_status_count_model.dart';
import 'package:taskmanager/data/models/task_status_model.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/models/task_list_model.dart';
import 'package:taskmanager/data/models/task_model.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/screens/add_new_task_screen.dart';
import 'package:taskmanager/ui/widgets/build_summery_section.dart';
import 'package:taskmanager/ui/widgets/center_circular_progress.dart';

import 'package:taskmanager/ui/widgets/snack_bar_message.dart';
import 'package:taskmanager/ui/widgets/task_card.dart';
import 'package:taskmanager/ui/widgets/task_summery_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskListProgress = false;

  List<TaskModel> _newTaskList = [];


  @override
  void initState() {
    super.initState();
    _getNewTasklist();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getNewTasklist();

        },
        child: Column(
          children: [
            BuildSummerySection(),
            Expanded(
              child: Visibility(
                visible: !_getNewTaskListProgress,
                replacement: const CenterCircularProgress(),
                child: ListView.separated(
                    itemCount: _newTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskModel: _newTaskList[index],
                        onRefreshList: () => _getNewTasklist(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddFAB,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _onTapAddFAB() async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewTaskScreen(),
      ),
    );
    if (shouldRefresh == true) {
      _getNewTasklist();
    }
  }

  Future<void> _getNewTasklist() async {
    _newTaskList.clear();
    _getNewTaskListProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.newTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _newTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getNewTaskListProgress = false;
    setState(() {});
  }






}
