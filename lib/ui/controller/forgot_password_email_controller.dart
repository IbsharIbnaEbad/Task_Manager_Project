import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/screens/forgot_password_otp_screen.dart';

class ForgotPasswordEmailController extends GetxController {

  bool _inprogress = false;

  bool get inprogress => _inprogress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> sendEmailVerificationRequest(String email) async {

    bool isSuccess = false;
    _inprogress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.recoverEmail(email),
    );

    if (response.isSuccess) {
      Get.to(() => ForgotPasswordOTPScreen(email: email,),);
      isSuccess = true;
    } else {
    _errorMessage = response.errorMessage;
    }
    _inprogress = false;
    update();

    return isSuccess;
  }

}