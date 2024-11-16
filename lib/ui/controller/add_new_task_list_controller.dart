import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';

class AddNewTaskListController extends GetxController {
  bool _inprogress = false;

  String? _errorMessage;

  bool get inprogress => _inprogress;

  String? get errorMessage => _errorMessage;

  Future<bool> addNewTask(
      String title, String description, String status) async {
    bool isSuccess = false;
    _inprogress = true;
    update();

    Map<String, dynamic> requestbody = {
      "title": title,
      "description": description,
      "status": status,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.addNewTask, body: requestbody);

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inprogress = false;
    update();

    return isSuccess;
  }
}
