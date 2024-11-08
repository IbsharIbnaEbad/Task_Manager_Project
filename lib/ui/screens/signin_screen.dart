import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/login_model.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';
import 'package:taskmanager/ui/screens/forgot_password_email_screen.dart';
import 'package:taskmanager/ui/screens/main_bottom_navbar_screen.dart';
import 'package:taskmanager/ui/screens/signup_screen.dart';
import 'package:taskmanager/ui/utils/app_colors.dart';
import 'package:taskmanager/ui/widgets/Screenbackground.dart';
import 'package:taskmanager/ui/widgets/center_circular_progress.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  bool _inprogress = false;

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
                  'Get Started With',
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                _buildsigninform(),
                const SizedBox(
                  height: 14,
                ),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: _onTapForgetPasswordButton,
                        child: const Text(
                          'forget your password ',
                          style:
                              TextStyle(letterSpacing: 0.5, color: Colors.grey),
                        ),
                      ),
                      _buildSignUpSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapForgetPasswordButton() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ForgotPasswordEmailScreen()));
  }

  Widget _buildsigninform() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter your Email';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _passwordTEController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter your password';
              }
              if (value!.length <= 6) {
                return 'enter a password with length grater then 6';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: !_inprogress,
            replacement: const CenterCircularProgress(),
            child: ElevatedButton(
              onPressed: _onTapNextButton,
              child: const Icon(
                Icons.arrow_circle_right_outlined,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: (Colors.black),
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        text: 'Dont have an account ?  ',
        children: [
          TextSpan(
              text: 'Sign up ',
              style: const TextStyle(
                color: AppColor.BackgroungClr,
              ),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignUp),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    _signIn();
  }

  Future<void> _signIn() async {
    _inprogress = true;
    setState(() {});
    Map<String, dynamic> requestbody = {
      'email': _emailTEController.text.trim(),
      'password': _passwordTEController.text,
    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.login, body: requestbody);
    _inprogress = false;
    setState(() {});
    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainBottomNavbarScreen()),
          (value) => false);
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _onTapSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }
}
