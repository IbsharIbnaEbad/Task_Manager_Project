import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/task_list_model.dart';
import 'package:taskmanager/data/models/task_model.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';

class ProgressTaskController extends GetxController {
  bool _inprogress = false;

  String? _errorMessage;

  bool get inprogress => _inprogress;

  String? get errorMessage => _errorMessage;

  List<TaskModel> _taskList = [];

  List<TaskModel> get taskList => _taskList;

  Future<bool> getProgressTaskList() async {
    bool isSuccess = false;
    _inprogress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.ProgressTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _taskList = taskListModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inprogress = false;
    update();

    return isSuccess;
  }
}
