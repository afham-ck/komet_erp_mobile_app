sealed class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure([
    super.message = 'An unexpected error occurred',
    this.statusCode,
  ]);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Unauthorized']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'Connection failed. Please check your network connection or try after some time',
  ]);
}

class UnknownFailure extends Failure {
  const UnknownFailure([
    super.message = 'Something went wrong. Please try after some time',
  ]);
}
