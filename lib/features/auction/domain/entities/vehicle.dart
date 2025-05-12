import 'package:equatable/equatable.dart';

class Vehicle extends Equatable {
  final String? make;
  final String? model;
  final String? containerName;
  final double? similarity;
  final String? externalId;

  const Vehicle({this.make, this.model, this.containerName, this.similarity, this.externalId});

  @override
  List<Object?> get props => [make, model, containerName, similarity, externalId];
}
