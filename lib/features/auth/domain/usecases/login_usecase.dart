import 'dart:async';

import '../../../../core/usecases/single_usecase_with_parameter.dart';
import '../../../../core/usecases/usecase_value.dart';
import '../repositories/index.dart' show AbstractAuthRepository;

class LoginUsecase extends SingleUsecaseWithParameter<String, String> {
  final AbstractAuthRepository repo;

  LoginUsecase(this.repo);

  @override
  FutureOr<UsecaseValue<String>> call(String data) {
    return repo.login(data);
  }
}
