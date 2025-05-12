import '../../../../core/usecases/usecase_value.dart';

abstract class AbstractAuthRepository {
  Future<UsecaseValue<String?>> getUserInfo();
  Future<UsecaseValue<String>> login(String username);
}
