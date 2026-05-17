class ImageUploadException implements Exception {
  final String message;
  final int? statusCode;

  ImageUploadException(this.message, {this.statusCode});

  @override
  String toString() {
    return "ImageUploadException: $message${statusCode != null ? ' (code: $statusCode)' : ''}";
  }
}
