import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../features/auction/domain/entities/auction.dart';
import '../../features/auction/presentation/screens/auction_details_screen.dart';
import '../../features/auction/presentation/screens/home_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';

class RouteList {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String auctionDetails = '/auction_details';
}

GoRouter get applicationRouter => _router;

final dInstance = GetIt.instance;

final GoRouter _router = GoRouter(
  initialLocation: RouteList.splash,
  routes: <RouteBase>[
    GoRoute(
      path: RouteList.splash,
      name: RouteList.splash,
      builder: (BuildContext context, GoRouterState state) {
        return SplashScreen(bloc: dInstance.call());
      },
    ),
    GoRoute(
      path: RouteList.login,
      name: RouteList.login,
      builder: (BuildContext context, GoRouterState state) {
        return LoginScreen(bloc: dInstance.call());
      },
    ),
    GoRoute(
      path: RouteList.home,
      name: RouteList.home,
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen(bloc: dInstance.call());
      },
      routes: [
        GoRoute(
          path: RouteList.auctionDetails,
          name: RouteList.auctionDetails,
          builder: (context, state) {
            return AuctionDetailsScreen(details: state.extra as Auction);
          },
        ),
      ],
    ),
  ],
);
