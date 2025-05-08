import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../exceptions/server_exception.dart';

class ServerResponse<T> extends Equatable {
  final T? data;

  final int? statusCode;

  final String? statusMessage;

  const ServerResponse({this.data, this.statusCode, this.statusMessage,});

  @override
  List<Object?> get props => [this.data, this.statusCode, this.statusMessage];

  bool get ok {
    return ((statusCode ?? 0) ~/ 100) == 2;
  }

  ServerResponse copyWith({T? data, int? statusCode, String? statusMessage,}) =>
      ServerResponse(
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
        statusMessage: statusMessage ?? this.statusMessage,
      );

  dynamic getData() {
    if (this.ok) {
      if (data is String) {
        return jsonDecode(this.data as String);
      }

      return this.data;
    }

    switch (statusCode) {
      default:
        throw ServerException(message: this.statusMessage);
    }
  }
}
