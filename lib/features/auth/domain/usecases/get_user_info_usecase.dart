import 'dart:async';

import '../../../../core/usecases/single_usecase.dart';
import '../../../../core/usecases/usecase_value.dart';
import '../repositories/index.dart' show AbstractAuthRepository;

class GetUserInfoUsecase extends SingleUsecase<String?> {
  final AbstractAuthRepository repo;

  GetUserInfoUsecase(this.repo);

  @override
  FutureOr<UsecaseValue<String?>> call() {
    return repo.getUserInfo();
  }
}
