import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/screens/reset_password_screen.dart';

class ForgotPasswordOtpController extends GetxController{

  bool _inprogress = false;

  bool get inprogress => _inprogress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> verifyOTP(String email, String otp) async {
    bool isSuccess = false;
    _inprogress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.otpEmail(email, otp),
    );

    if (response.isSuccess) {
      Get.to(() => ResetPasswordScreen(email: email, otp: otp));
      isSuccess = true;
    } else {
      _errorMessage =  response.errorMessage;
    }

    _inprogress = false;
    update();
    return isSuccess;
  }
}