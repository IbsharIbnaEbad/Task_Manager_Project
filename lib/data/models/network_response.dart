class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  dynamic responseData;
  String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.errorMessage = 'something is wrong',
    this.responseData,
  });
}
