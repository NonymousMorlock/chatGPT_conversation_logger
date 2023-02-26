import 'package:equatable/equatable.dart';

class CacheException extends Equatable implements Exception {
  const CacheException({
    required this.message,
    required this.statusCode,
    required this.stackTrace,
  });

  final String message;

  final int statusCode;
  final StackTrace stackTrace;

  @override
  List<Object?> get props => [message, statusCode];
}
