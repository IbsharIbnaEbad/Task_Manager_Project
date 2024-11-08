import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/screens/reset_password_screen.dart';
import 'package:taskmanager/ui/screens/signin_screen.dart';
import 'package:taskmanager/ui/utils/app_colors.dart';
import 'package:taskmanager/ui/widgets/Screenbackground.dart';
import 'package:taskmanager/ui/widgets/center_circular_progress.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';

class ForgotPasswordOTPScreen extends StatefulWidget {
  final String email; // Email passed from previous screen
  const ForgotPasswordOTPScreen({super.key, required this.email});

  @override
  State<ForgotPasswordOTPScreen> createState() =>
      _ForgotPasswordOTPScreenState();
}

class _ForgotPasswordOTPScreenState extends State<ForgotPasswordOTPScreen> {
  bool _forgetPasswordOtpInProgress = false;
  TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: background(
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
        Visibility(
          visible: !_forgetPasswordOtpInProgress,
          replacement: const CenterCircularProgress(),
          child: ElevatedButton(
            onPressed: _onTapNextButton,
            child: const Icon(
              Icons.arrow_circle_right_outlined,
            ),
          ),
        ),
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
      showSnackBarMessage(context, 'Please enter a valid 6-digit OTP', true);
      return;
    }

    await _verifyOTP(email, otp);
  }

  Future<void> _verifyOTP(String email, String otp) async {
    setState(() {
      _forgetPasswordOtpInProgress = true;
    });

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.otpEmail(email, otp),
    );

    if (response.isSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(email: email, otp: otp)),
      );
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }

    setState(() {
      _forgetPasswordOtpInProgress = false;
    });
  }

  void _onTapSignIn() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
      (_) => false,
    );
  }
}
