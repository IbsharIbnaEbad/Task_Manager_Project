import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';
import 'package:taskmanager/ui/widgets/tm_app_bar.dart';


class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  bool _addNewTaskInProgress = false;
  bool _shouldRefreshPreviousPage =false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if(didPop){
          return;
        }
        Navigator.pop(context,_shouldRefreshPreviousPage);
      },
      child: Scaffold(
        appBar: TMAppBar(),
        body: SingleChildScrollView(
          //todo check note for details
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 42,
                  ),
                  Text('Add New Task ',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: _titleTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(hintText: 'Title'),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _descriptionTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 5,
                    decoration: InputDecoration(hintText: 'Description'),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: !_addNewTaskInProgress,
                    replacement: CircularProgressIndicator(),
                    child: ElevatedButton(
                        onPressed: _onTapSubmitButton,
                        child: Icon(Icons.arrow_circle_right_outlined)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formkey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});
    Map<String, dynamic> requestbody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New"
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.addNewTask, body: requestbody);
    _addNewTaskInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _shouldRefreshPreviousPage=true;
      _clearTextField();
      showSnackBarMessage(context, 'new task added');
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _clearTextField() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }
}
