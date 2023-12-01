// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:jobjolt/app/page/app_start_page.dart';
import 'package:jobjolt/feature/auth/page/sign_in.page.dart';
import 'package:jobjolt/feature/auth/page/sign_up.page.dart';

part 'app_router.g.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

@riverpod
GoRouter router(RouterRef ref) {
  //final notifier = ref.watch(routerNotifierProvider.notifier);

  return GoRouter(
    navigatorKey: globalNavigatorKey,
    //refreshListenable: notifier,
    debugLogDiagnostics: true,
    initialLocation: AppRoute.path,
    routes: $appRoutes,
    //redirect: notifier.redirect,
  );
}

@TypedGoRoute<AppRoute>(path: AppRoute.path)
class AppRoute extends GoRouteData {
  const AppRoute();

  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppStartPage();
  }
}

@TypedGoRoute<SignInRoute>(path: SignInRoute.path)
class SignInRoute extends GoRouteData {
  const SignInRoute();

  static const path = '/signIn';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignInPage();
  }
}

@TypedGoRoute<SignUpRoute>(path: SignUpRoute.path)
class SignUpRoute extends GoRouteData {
  const SignUpRoute();

  static const path = '/signUp';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SignUpPage();
  }
}

class GoNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('did push route ${route} : ${previousRoute}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('did pop route ${route} : ${previousRoute}');
  }
}
