import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/user_model.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';

class ProfileScreenController extends GetxController {
  bool _inprogress = false;

  bool get inprogress => _inprogress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> updateProfile(String email, String firstName, String lastName,
      String mobile, String? password, String? photo) async {
    bool isSuccess = false;
    _inprogress = true;
    update();

    Map<String, dynamic> requestbody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if (password != null && password.isNotEmpty) {
      requestbody['password'] = password;
    }

    if (photo != null) {
      requestbody['photo'] = photo;
    }

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfile,
      body: requestbody,
    );

    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(requestbody);
      AuthController.saveUserData(userModel);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inprogress = false;
    update();
    return isSuccess;
  }
}
