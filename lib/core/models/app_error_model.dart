class AppErrorModel {
  final String message;
  final String? details;

  AppErrorModel(this.message, {this.details});

  @override
  String toString() {
    return 'AppError: $message ${details != null ? "Details: $details" : ""}';
  }
}
