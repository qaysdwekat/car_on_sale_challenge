part of 'app_exception.dart';

class MultipleChoicesException<T> extends AppException {
  final T data;
  const MultipleChoicesException({required this.data, super.message, super.debugMessage});

  @override
  List<Object?> get props => [data, message, debugMessage];
}
