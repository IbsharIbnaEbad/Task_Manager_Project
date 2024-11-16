import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskmanager/ui/controller/forgot_password_otp_controller.dart';
import 'package:taskmanager/ui/screens/signin_screen.dart';
import 'package:taskmanager/ui/utils/app_colors.dart';
import 'package:taskmanager/ui/widgets/Screenbackground.dart';
import 'package:taskmanager/ui/widgets/center_circular_progress.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';

class ForgotPasswordOTPScreen extends StatefulWidget {
  static const String name = '/forgotOtp';

  final String email; // Email passed from previous screen
  const ForgotPasswordOTPScreen({super.key, required this.email});

  @override
  State<ForgotPasswordOTPScreen> createState() =>
      _ForgotPasswordOTPScreenState();
}

class _ForgotPasswordOTPScreenState extends State<ForgotPasswordOTPScreen> {
  bool _forgetPasswordOtpInProgress = false;
  final TextEditingController _otpController = TextEditingController();
  final ForgotPasswordOtpController _forgotPasswordOtpController =
      Get.find<ForgotPasswordOtpController>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 84,
                ),
                Text(
                  'Pin Verification  ',
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'A 6 digit verification otp will be sent to your email address',
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 23,
                ),
                _buildVerifyEmail(),
                const SizedBox(
                  height: 47,
                ),
                Center(child: _buildHaveAccountSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyEmail() {
    return Column(
      children: [
        PinCodeTextField(
          controller: _otpController,
          length: 6,
          obscureText: false,
          keyboardType: TextInputType.number,
          animationType: AnimationType.scale,
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          appContext: context,
        ),
        const SizedBox(
          height: 20,
        ),
        GetBuilder<ForgotPasswordOtpController>(builder: (controller) {
          return Visibility(
            visible: !controller.inprogress,
            replacement: const CenterCircularProgress(),
            child: ElevatedButton(
              onPressed: _onTapNextButton,
              child: const Icon(
                Icons.arrow_circle_right_outlined,
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: (Colors.black),
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        text: 'Have account ?  ',
        children: [
          TextSpan(
            text: 'Sign In ',
            style: const TextStyle(
              color: AppColor.BackgroungClr,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
          ),
        ],
      ),
    );
  }

  // void _onTapNextButton() {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => ResetPasswordScreen()));
  // }

  void _onTapNextButton() async {
    String otp = _otpController.text.trim();
    String email = widget.email;

    if (otp.isEmpty || otp.length != 6) {
      // showSnackBarMessage(context, 'Please enter a valid 6-digit OTP', true);
      Get.snackbar(
        "Error",
        "Please enter a valid 6-digit OTP",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    await _verifyOTP(email, otp);
  }

  Future<void> _verifyOTP(String email, String otp) async {
    final bool result = await _forgotPasswordOtpController.verifyOTP(
      email,
      otp,
    );
    if (result == false) {
      showSnackBarMessage(
          context, _forgotPasswordOtpController.errorMessage!, true);
    }
  }

  void _onTapSignIn() {
/*
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
      (_) => false,
    );
*/
    Get.offAll(() => const SignInScreen());
  }
}
