import 'package:equatable/equatable.dart';

part 'general_exception.dart';
part 'multiple_choices_exception.dart';
part 'server_exception.dart';
part 'unauthorized_exception.dart';

sealed class AppException extends Equatable {
  final String? message;
  final String? debugMessage;

  const AppException({this.message, this.debugMessage});

  @override
  List<Object?> get props => [message, debugMessage];
}
