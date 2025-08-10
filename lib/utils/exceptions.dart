class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException(super.message);
}

class BadRequestException extends AppException {
  BadRequestException(super.message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(super.message);
}

class ForbiddenException extends AppException {
  ForbiddenException(super.message);
}

class NotFoundException extends AppException {
  NotFoundException(super.message);
}

class InternalServerException extends AppException {
  InternalServerException(super.message);
}

class FetchDataException extends AppException {
  FetchDataException(super.message);
}
