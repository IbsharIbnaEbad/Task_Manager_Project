import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/ui/screens/signin_screen.dart';

class ResetPasswordController extends GetxController {
  bool _inprogress = false;

  bool get inprogress => _inprogress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> onTapNextButton(
      String email, String otp, String newPassword) async {
    bool isSuccess = false;
    _inprogress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": newPassword,
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: 'http://35.73.30.144:2005/api/v1/RecoverResetPassword/',
      body: requestBody,
    );

    if (response.isSuccess) {
      Get.snackbar(
        "Success",
        "Password reset successful",
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAll(
        () => const SignInScreen(),
        opaque: false,
      );
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Failed to reset password';
      update();
      Get.snackbar(
        "Error",
        _errorMessage!,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }

    _inprogress = false;
    update();
    return isSuccess;
  }
}
