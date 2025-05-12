import 'dart:convert';

import 'package:car_on_sale_challenge/features/auction/data/models/vehicle_model.dart';
import 'package:car_on_sale_challenge/features/auction/domain/entities/vehicle.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final newVehicleModel = VehicleModel(
    make: "Toyota",
    model: "GT 86 Basis",
    containerName: "DE - Cp2 2.0 EU5, 2012 - 2015",
    similarity: 75,
    externalId: "DE001-018601450020001",
  );

  test('Test a sublclass of VehicleModel entity', () async {
    //asset
    expect(newVehicleModel, isA<Vehicle>());
  });

  group("FromJson Test", () {
    test("Should return a valid model from the JSON", () async {
      //arrange
      final Map<String, dynamic> vehicleJson = json.decode(fixture('vehicle.json'));
      //act
      final result = VehicleModel.fromJson(vehicleJson);
      //assert
      expect(result, newVehicleModel);
    });
  });

  group('ToJson Test', () {
    test("Should return a JSON map containing the proper data", () async {
      //arrange
      final result = newVehicleModel.toJson();
      //assert
      final expectedMap = json.decode(fixture('vehicle.json'));
      expect(result, expectedMap);
    });
  });
}
