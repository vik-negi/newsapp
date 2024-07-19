// lib/core/failures/failure.dart
import 'package:equatable/equatable.dart';
import 'package:news/utils/service/exceptions.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  String get errorMessage => 'Error : $message';

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure() : super('Server error');

  @override
  List<Object?> get props => [super.message];
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('Network error');

  @override
  List<Object?> get props => [super.message];
}

class APIFailure extends Failure {
  final Map<String, dynamic>? faliureData;
  const APIFailure(super.message, {this.faliureData});
  APIFailure.fromException(APIException exception) : this(exception.message);
}
// Other failure classes
