import 'package:conversation_log/core/common/errors/failures.dart';
import 'package:dartz/dartz.dart';

typedef DataMap = Map<String, dynamic>;
typedef FunctionalFuture<T> = Future<Either<Failure, T>>;
