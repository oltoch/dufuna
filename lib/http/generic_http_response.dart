///A custom class for getting response from an http request
class GenericHttpResponse {
  bool success;
  int? status;
  String? message;
  dynamic body;
  dynamic error;

  GenericHttpResponse({
    this.success = false,
    this.status = 200,
    this.message = 'ok',
    this.body,
    this.error,
  });
}
