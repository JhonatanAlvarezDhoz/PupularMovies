// Definition of custom errors
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  AppException(this.message, {this.code, this.details});
}

class NetworkException extends AppException {
  NetworkException(super.message, {super.code, super.details});
}

class AuthenticationException extends AppException {
  AuthenticationException(super.message, {super.code, super.details});
}

class ValidationException extends AppException {
  ValidationException(super.message, {super.code, super.details});
}

class NotFoundException extends AppException {
  NotFoundException(super.message, {super.code, super.details});
}

class ServerException extends AppException {
  ServerException(super.message, {super.code, super.details});
}

class FetchDataException extends AppException {
  FetchDataException(super.message, {super.code, super.details});
}

class BadRequestException extends AppException {
  BadRequestException(super.message, {super.code, super.details});
}

class UnauthorizedException extends AppException {
  UnauthorizedException(super.message, {super.code, super.details});
}

class InternalServerErrorException extends AppException {
  InternalServerErrorException(super.message, {super.code, super.details});
}

class ForbiddenException extends AppException {
  ForbiddenException(super.message, {super.code, super.details});
}
