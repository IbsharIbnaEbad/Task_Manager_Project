import 'package:get/get.dart';
import 'package:taskmanager/ui/controller/add_new_task_list_controller.dart';
import 'package:taskmanager/ui/controller/cancelled_task_controller.dart';
import 'package:taskmanager/ui/controller/completed_task_controller.dart';
import 'package:taskmanager/ui/controller/delete_status_controller.dart';
import 'package:taskmanager/ui/controller/edit_status_controller.dart';
import 'package:taskmanager/ui/controller/forgot_password_otp_controller.dart';
import 'package:taskmanager/ui/controller/new_task_list_controller.dart';
import 'package:taskmanager/ui/controller/profile_screen_controller.dart';
import 'package:taskmanager/ui/controller/progress_task_controller.dart';
import 'package:taskmanager/ui/controller/reset_password_controller.dart';
import 'package:taskmanager/ui/controller/sign_in_controller.dart';
import 'package:taskmanager/ui/controller/sign_up_controller.dart';
import 'package:taskmanager/ui/controller/task_list_count_controller.dart';
import 'ui/controller/forgot_password_email_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(NewTaskListController());
    Get.put(CompletedTaskController());
    Get.put(CancelledTaskController());
    Get.put(ProgressTaskController());
    Get.put(SignUpController());
    Get.put(ForgotPasswordOtpController());
    Get.put(ForgotPasswordEmailController());
    Get.put(ResetPasswordController());
    Get.put(ProfileScreenController());
    Get.put(AddNewTaskListController());
    Get.put(TaskListCountController());
    Get.put(EditStatusController());
    Get.put(DeleteStatusController());
  }
}
