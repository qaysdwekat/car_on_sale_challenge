import 'package:car_on_sale_challenge/core/exceptions/app_exception.dart';
import 'package:car_on_sale_challenge/core/usecases/usecase_value.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final List<Map<String, dynamic>> usecaseValueTestCases = [
    {
      'description': 'Return GeneralException Test',
      'expectedResult': null,
      'expectedError': true,
      'error': GeneralException(message: 'Some error'),
    },
    {
      'description': 'Return ServerException Test',
      'expectedResult': null,
      'expectedError': true,
      'error': ServerException(message: 'Internal Server Error'),
    },
    {
      'description': 'Return Success (String) Test',
      'expectedResult': 'Expecte Success Data',
      'expectedResultType': String,
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Return Success (Map) Test',
      'expectedResult': <String, dynamic>{'key1': 'value', 'key2': 1, 'key3': true},
      'expectedResultType': Map<String, dynamic>,
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Return Success (List) Test',
      'expectedResult': [1, 2, 3, 4],
      'expectedResultType': List<int>,
      'expectedError': false,
      'error': null,
    },
  ];

  group('UsecaseValue Results Test', () {
    for (var testCase in usecaseValueTestCases) {
      final description = testCase['description'];
      final expectedResult = testCase['expectedResult'];
      final expectedError = testCase['expectedError'];
      final type = testCase['expectedResultType'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the getTimeOut method in the MockNetworkConfigProvider
        if (expectedError) {
          final value = UsecaseValue.exception(error);
          expect(value, isA<AppFailureException>());
          final exception = (value as AppFailureException).exception;
          expect(exception, isA<AppException>());
          expect(exception, error);
        } else {
          final value = UsecaseValue.success(expectedResult);
          final expectedType = type as Type;
          final result = (value as UsecaseSuccess).result;
          //TODO:- Workaround to handle internal Dart classes.
          if (result.runtimeType.toString().startsWith('_')) {
            expect(result.runtimeType.toString().replaceFirst('_', ''), equals(expectedType.toString()));
          } else {
            expect(result.runtimeType, equals(expectedType));
          }
          expect(result, expectedResult);
        }
      });
    }
  });
}
