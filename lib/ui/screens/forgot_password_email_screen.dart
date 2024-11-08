import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/screens/forgot_password_otp_screen.dart';
import 'package:taskmanager/ui/utils/app_colors.dart';
import 'package:taskmanager/ui/widgets/Screenbackground.dart';
import 'package:taskmanager/ui/widgets/center_circular_progress.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  bool _forgetPasswordInProgress = false;
  final TextEditingController _emailController = TextEditingController();

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
                  'Your Email Address ',
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
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: 'Email'),
        ),
        const SizedBox(
          height: 20,
        ),
        Visibility(
          visible: !_forgetPasswordInProgress,
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

  Future<void> _onTapNextButton() async {
    String email = _emailController.text.trim();

    // Validate the email format
    if (email.isEmpty) {

      showSnackBarMessage(context, 'Please enter a valid email address',true);
      return;
    }

    await _sendEmailVerificationRequest(email);
  }

  Future<void> _sendEmailVerificationRequest(String email) async {
    _forgetPasswordInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.recoverEmail(email),
    );

    if (response.isSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ForgotPasswordOTPScreen(email: email,)),
      );
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }

    _forgetPasswordInProgress = false;
    setState(() {});
  }

/* void _onTapNextButton() {

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ForgotPasswordOTPScreen()));

  }*/

  void _onTapSignIn() {
    Navigator.pop(context);
  }
}
