import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';

class EditStatusController extends GetxController {
  bool _inprogress = false;

  bool get inprogress => _inprogress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> changeStatus(String taskId, String newStatus) async {
    bool isSuccess = false;
    _inprogress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.changeStatus(taskId, newStatus));
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
