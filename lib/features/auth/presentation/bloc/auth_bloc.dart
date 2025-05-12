import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase_value.dart';
import '../../domain/usecases/index.dart' show LoginUsecase, GetUserInfoUsecase;
import 'auth_state.dart';
import 'events/abstract_auth_event.dart' show AbstractAuthEvent;
import 'events/complete_animation_event.dart';
import 'events/get_user_info_event.dart';
import 'events/login_event.dart';

class AuthBloc extends Bloc<AbstractAuthEvent, AuthState> {
  AuthBloc(LoginUsecase loginUsecase, GetUserInfoUsecase getUserInfoUsecase) : super(InitialState()) {
    on<LoginEvent>((event, emit) async {
      emit(LoadingState(eventType: event.runtimeType, username: event.username));
      final response = await loginUsecase(event.username);
      switch (response) {
        case UsecaseSuccess():
          final username = response.result;
          emit(
            LoadedState.fromPrevious(
              state,
              eventType: event.runtimeType,
              username: username,
              loggedInUser: username.isNotEmpty == true,
            ),
          );
        case AppFailureException():
          emit(ErrorState(eventType: event.runtimeType, error: response.exception.message, username: event.username));
      }
    });

    on<GetUserInfoEvent>((event, emit) async {
      emit(LoadingState(eventType: event.runtimeType));
      final response = await getUserInfoUsecase();
      switch (response) {
        case UsecaseSuccess():
          final info = response.result;
          emit(
            LoadedState.fromPrevious(
              state,
              eventType: event.runtimeType,
              username: info,
              loggedInUser: info?.isNotEmpty == true,
            ),
          );
        case AppFailureException():
          emit(ErrorState(eventType: event.runtimeType, error: response.exception.message));
      }
    });

    on<CompleteAnimationEvent>((event, emit) async {
      emit(LoadedState.fromPrevious(state, eventType: event.runtimeType, animationCompelted: true));
    });
  }
}
