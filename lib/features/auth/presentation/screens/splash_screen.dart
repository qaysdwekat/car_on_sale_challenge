import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../bloc/events/complete_animation_event.dart';
import '../bloc/events/get_user_info_event.dart';
import 'widgets/animated_splash_child.dart';

class SplashScreen extends StatelessWidget {
  final int duration = 2000;

  final AuthBloc bloc;

  const SplashScreen({super.key, required this.bloc});

  AuthBloc onCreate(BuildContext context) {
    //Check if user already exists
    return bloc..add(GetUserInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: onCreate(context),
      child: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (previous, current) {
          return [GetUserInfoEvent, CompleteAnimationEvent].contains(current.eventType);
        },
        listener: (c, s) {
          if (s is LoadedState || s is ErrorState) {
            // Wait unti CompleteAnimation & Check if user already exists to go to next page
            goNext(s, c);
          }
        },
        builder: (c, s) {
          return buildScreen(c, s);
        },
      ),
    );
  }

  Widget buildScreen(BuildContext context, AuthState state) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xFF2F323E)),
        child: AnimatedSplashChild(
          next: () {
            bloc.add(CompleteAnimationEvent());
          },
          imagePath: 'assets/logo/car_on_sale_logo.svg',
          duration: duration,
          boxFit: BoxFit.contain,
          size: Size(size.width * 0.55, size.height * 0.25),
        ),
      ),
    );
  }

  void goNext(AuthState state, BuildContext context) {
    if (state.animationCompelted && state.loggedInUser != null) {
      if (state.loggedInUser == true) {
        context.replaceNamed(RouteList.home);
      } else {
        context.replaceNamed(RouteList.login);
      }
    }
  }
}
