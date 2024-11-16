import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/task_status_count_model.dart';
import 'package:taskmanager/data/models/task_status_model.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';

class TaskListCountController extends GetxController {
  bool _inprogress = false;

  String? _errorMessage;

  bool get inprogress => _inprogress;

  String? get errorMessage => _errorMessage;

  List<TaskStatusModel> _taskList = [];

  List<TaskStatusModel> get taskList => _taskList;

  Future<bool> getTaskStatusCount() async {
    bool isSuccess = false;
    _inprogress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskStatusCount);
    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel =
          TaskStatusCountModel.fromJson(response.responseData);
      _taskList = taskStatusCountModel.taskStatusCountList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inprogress = false;
    update();
    return isSuccess;
  }
}
