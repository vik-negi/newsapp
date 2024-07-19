import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:news/utils/service/failure.dart';

typedef APIResponse<T> = Future<Either<Failure, T>>;

typedef FaliureEither<T> = Either<Failure, T>;

typedef FormSubmitCallbackHandler<T> = Future<String> Function(T value);

void handleResponse<T>(
    Either<Failure, T> res, Function(T) onSuccess, Function(Failure) onError) {
  res.fold(
    (l) {
      onError(l);
    },
    (r) {
      onSuccess(r);
    },
  );
}
