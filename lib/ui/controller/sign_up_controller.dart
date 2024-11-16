import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';

class SignUpController extends GetxController {
  bool _inprogress = false;

  bool get inprogress => _inprogress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> signup(String email, String firstName, String lastName,
      String mobile, String password) async {
    bool isSuccess = false;
    _inprogress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": ""
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.registration,
      body: requestBody,
    );
    if (response.isSuccess) {
      //showSnackBarMessage('New user created');
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inprogress = false;
    update();

    return isSuccess;
  }
}
