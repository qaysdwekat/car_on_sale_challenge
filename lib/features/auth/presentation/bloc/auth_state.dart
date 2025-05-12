import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  final Type? eventType;
  final String? username;
  final bool animationCompelted;
  final bool? loggedInUser;

  const AuthState({this.eventType, this.username, this.animationCompelted = false, this.loggedInUser});

  @override
  List<Object?> get props => [username, loggedInUser, animationCompelted, eventType];
}

class InitialState extends AuthState {
  const InitialState() : super();
}

class LoadingState extends AuthState {
  const LoadingState({super.eventType, super.username});
}

class LoadedState extends AuthState {
  const LoadedState({super.eventType, super.username, super.animationCompelted, super.loggedInUser});

  factory LoadedState.fromPrevious(
    AuthState previous, {
    Type? eventType,
    String? username,
    bool? animationCompelted,
    bool? loggedInUser,
  }) {
    return LoadedState(
      eventType: eventType ?? previous.eventType,
      username: username ?? previous.username,
      animationCompelted: animationCompelted ?? previous.animationCompelted,
      loggedInUser: loggedInUser ?? previous.loggedInUser,
    );
  }
}

class ErrorState extends AuthState {
  final String? error;

  const ErrorState({super.eventType, this.error, super.username});

  @override
  List<Object?> get props => [username, loggedInUser, error, eventType];
}
