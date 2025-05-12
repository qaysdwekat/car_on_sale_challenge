import 'package:car_on_sale_challenge/features/auction/domain/entities/vehicle.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/auction.dart';

sealed class AuctionState extends Equatable {
  final Type? eventType;
  final String? vin;

  const AuctionState({this.eventType, this.vin});

  @override
  List<Object?> get props => [vin, eventType];
}

class InitialState extends AuctionState {
  const InitialState() : super();
}

class LoadingState extends AuctionState {
  const LoadingState({super.eventType, super.vin});
}

class SessionExpiredState extends AuctionState {}

class MultipleChoicesState extends AuctionState {
  final List<Vehicle> vehicles;

  const MultipleChoicesState(this.vehicles);
}

class AuctionDetailsState extends AuctionState {
  final Auction details;

  const AuctionDetailsState({super.eventType, required this.details});
}

class ErrorState extends AuctionState {
  final String? error;

  const ErrorState({super.eventType, this.error, super.vin});

  @override
  List<Object?> get props => [vin, error, eventType];
}
