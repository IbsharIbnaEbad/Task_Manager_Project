import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/user_model.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';
import 'package:taskmanager/ui/widgets/center_circular_progress.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';
import 'package:taskmanager/ui/widgets/tm_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _updateProfileInprogress = false;

  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() {
    _emailTEController.text = AuthController.userData?.email ?? '';
    _firstNameTEController.text = AuthController.userData?.firstName ?? '';
    _lastNameTEController.text = AuthController.userData?.lastName ?? '';
    _phoneTEController.text = AuthController.userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(
        isProfileScreenOpen: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 84),
                Text(
                  'Update Profile',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 32),
                _buildPhotoPicker(),
                const SizedBox(height: 8),
                TextFormField(
                  enabled:  false,
                  controller: _emailTEController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (String ?value){
                    if (value?.trim().isEmpty??true){
                      return 'Enter your valid email';
                    }
                    return null;
                    } ,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _firstNameTEController,
                  decoration: const InputDecoration(hintText: 'First Name'),
                  validator: (String ?value){
                    if (value?.trim().isEmpty??true){
                      return 'Enter your valid First Name';
                    }
                    return null;
                  } ,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _lastNameTEController,
                  decoration: const InputDecoration(hintText: 'Last Name'),
                  validator: (String ?value){
                    if (value?.trim().isEmpty??true){
                      return 'Enter your valid last name';
                    }
                    return null;
                  } ,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneTEController,
                  decoration: const InputDecoration(hintText: 'Phone'),
                  validator: (String ?value){
                    if (value?.trim().isEmpty??true){
                      return 'Enter your valid phone';
                    }
                    return null;
                  } ,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordTEController,
                  decoration: const InputDecoration(hintText: 'Password'),

                ),
                const SizedBox(height: 16),
                Visibility(
                  replacement: CenterCircularProgress(),
                  visible: !_updateProfileInprogress,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          _updateProfile();
                        }
                      },
                      child: const Icon(Icons.arrow_circle_down_outlined)),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPicker() {
    return GestureDetector(
      onTap: _pickedImage,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Photo',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(_getSelectedPhotoTitle()),
          ],
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    _updateProfileInprogress = true;
    setState(() {});
    Map<String, dynamic> requestbody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneTEController.text.trim(),
    };
    if (_passwordTEController.text.isNotEmpty) {
      requestbody['password'] = _passwordTEController.text;
    }
    if (_selectedImage != null) {
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      String convertedImage = base64UrlEncode(imageBytes);
      requestbody['photo'] = convertedImage;
    }

    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.updateProfile, body: requestbody);
    _updateProfileInprogress = false;
    setState(() {});
    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(requestbody);
    AuthController.saveUserData(userModel);
      showSnackBarMessage(context, 'profile updated');
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
  }

  String _getSelectedPhotoTitle() {
    if (_selectedImage != null) {
      return _selectedImage!.name;
    }
    return 'Selected Photo';
  }

  Future<void> _pickedImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _selectedImage = pickedImage;
      setState(() {});
    }
  }
}
