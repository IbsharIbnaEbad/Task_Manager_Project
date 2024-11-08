class Urls {
  // static const String _baseUrl ='http://152.42.163.176:2006/api/v1';
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';

  static const String registration = '$_baseUrl/Registration';
  static const String login = '$_baseUrl/Login';
  static const String addNewTask = '$_baseUrl/createTask';
  static const String newTaskList = '$_baseUrl/listTaskByStatus/New';
  static const String CompletedTaskList =
      '$_baseUrl/listTaskByStatus/Completed';
  static const String CencelledTaskList =
      '$_baseUrl/listTaskByStatus/Cencelled';
  static const String ProgressTaskList = '$_baseUrl/listTaskByStatus/Progress';
  static const String taskStatusCount = '$_baseUrl/taskStatusCount';
  static const String updateProfile = '$_baseUrl/ProfileUpdate';

  static String changeStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';

  static String deleteTask(
    String taskId,
  ) =>
      '$_baseUrl/deleteTask/$taskId';

  static String recoverEmail(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';

  static String otpEmail(String email, String otp) =>
      '$_baseUrl/RecoverVerifyOtp/$email/$otp';

  static String resetPassword(String email, String otp) =>
      '$_baseUrl/RecoverResetPassword';
}
