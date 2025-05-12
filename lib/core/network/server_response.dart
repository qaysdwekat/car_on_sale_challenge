import 'dart:convert';

import 'package:car_on_sale_challenge/core/utils/string_extention.dart';
import 'package:equatable/equatable.dart';

import '../exceptions/index.dart';

class ServerResponse<T> extends Equatable {
  final T? data;

  final int? statusCode;

  final String? statusMessage;

  const ServerResponse({this.data, this.statusCode, this.statusMessage});

  @override
  List<Object?> get props => [this.data, this.statusCode, this.statusMessage];

  bool get ok {
    return ((statusCode ?? 0) ~/ 100) == 2;
  }

  bool get multipleChoices {
    return ((statusCode ?? 0) ~/ 100) == 3;
  }

  ServerResponse copyWith({T? data, int? statusCode, String? statusMessage}) => ServerResponse(
    data: data ?? this.data,
    statusCode: statusCode ?? this.statusCode,
    statusMessage: statusMessage ?? this.statusMessage,
  );

  dynamic getData() {
    final currentData = data;
    if (this.ok) {
      if (currentData is String) {
        try {
          return jsonDecode(currentData);
        } on FormatException catch (_) {
          return jsonDecode(currentData.tryFixJsonMissingCommas);
        }
      }

      return this.data;
    } else if (this.multipleChoices) {
      if (data is String) {
        return jsonDecode(this.data as String);
      }

      return this.data;
    }

    switch (statusCode) {
      case 400:
        final jsonError = jsonDecode(this.data as String);
        throw ServerException(message: jsonError['message']);
      default:
        throw ServerException(message: this.statusMessage);
    }
  }
}
