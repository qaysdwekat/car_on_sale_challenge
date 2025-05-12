import 'package:car_on_sale_challenge/core/utils/string_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route.dart';
import '../../../../generated/l10n.dart';
import '../../../../widgets/car_on_sale_widget.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../bloc/events/login_event.dart';

class LoginScreen extends StatelessWidget {
  final AuthBloc bloc;
  LoginScreen({super.key, required this.bloc});
  final _formKey = GlobalKey<FormState>();

  AuthBloc onCreate(BuildContext context) {
    return bloc;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: onCreate(context),
      child: BlocConsumer<AuthBloc, AuthState>(
        buildWhen: (previous, current) {
          return [LoginEvent].contains(current.eventType) || previous.username != current.username;
        },
        listener: (c, s) {
          if (s is LoadedState || s is ErrorState) {
            if (s.loggedInUser == true) {
              c.replaceNamed(RouteList.home);
            }
          }
        },
        builder: (c, s) {
          return buildScreen(c, s);
        },
      ),
    );
  }

  Widget buildScreen(BuildContext context, AuthState state) {
    return Scaffold(
      backgroundColor: Color(0xFF2F323E),
      body: CarOnSaleWidget(
        isLoading: state is LoadingState,
        title: S.current.welcome,
        action: S.current.login,
        placeholder: S.current.username,
        onPressed: (String value) {
          bloc.add(LoginEvent(value));
        },
        validator: (value) {
          if (value == null || value.isEmpty) return S.current.username_required_error;
          if (!value.isValidEmail) return S.current.username_validation_error;
          return null;
        },
      ),
    );
  }
}
