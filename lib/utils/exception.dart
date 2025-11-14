class BusinessException implements Exception {
  int code = 0;
  String message = "";

  BusinessException(
    String message,[int code = 0]
  ) {
    this.code = code;
    this.message = message;
  }

  @override
  String toString() => message;
}
