import 'package:car_on_sale_challenge/core/exceptions/app_exception.dart';

import '../../../../core/usecases/usecase_value.dart' show UsecaseValue;
import '../../domain/repositories/index.dart' show AbstractAuthRepository;
import '../datasources/index.dart' show AbstractAuthDatasource;

class AuthRepository implements AbstractAuthRepository {
  final AbstractAuthDatasource datasource;

  AuthRepository(this.datasource);

  @override
  Future<UsecaseValue<String>> login(String username) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      final response = await datasource.login(username);
      return UsecaseValue.success(response);
    } catch (e) {
      return UsecaseValue.exception(GeneralException(message: e.toString()));
    }
  }

  @override
  Future<UsecaseValue<String?>> getUserInfo() async {
    try {
      final response = await datasource.getUserInfo();
      return UsecaseValue.success(response);
    } catch (e) {
      return UsecaseValue.exception(GeneralException(message: e.toString()));
    }
  }
}
