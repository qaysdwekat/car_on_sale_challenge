import 'package:car_on_sale_challenge/features/auction/domain/entities/vehicle.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const vehicle = Vehicle(
    make: "Toyota",
    model: "GT 86 Basis",
    containerName: "DE - Cp2 2.0 EU5, 2012 - 2015",
    similarity: 75,
    externalId: "DE001-018601450020001",
  );

  test('Test Create a Vehicle entity with correct values', () {
    expect(vehicle.make, equals("Toyota"));
    expect(vehicle.similarity, equals(75));
  });

  test('Test equality comparison', () {
    const another = Vehicle(
      make: "Toyota",
      model: "GT 86 Basis",
      containerName: "DE - Cp2 2.0 EU5, 2012 - 2015",
      similarity: 75,
      externalId: "DE001-018601450020001",
    );

    expect(vehicle, equals(another));
  });
}
