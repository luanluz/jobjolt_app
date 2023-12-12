// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:jobjolt/feature/applicant/page/applicant.page.dart';
import 'package:jobjolt/feature/company/page/company.page.dart';
import 'package:jobjolt/feature/profile/page/profile.page.dart';
import 'package:jobjolt/feature/vacancy/page/vacancy.page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:jobjolt/app/page/app_start_page.dart';
import 'package:jobjolt/feature/auth/page/sign_in.page.dart';
import 'package:jobjolt/feature/auth/page/sign_up.page.dart';

part 'app_router.g.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    navigatorKey: globalNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: AppRoute.path,
    routes: $appRoutes,
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
    return const SignUpPage();
  }
}

@TypedGoRoute<ApplicantRoute>(path: ApplicantRoute.path)
class ApplicantRoute extends GoRouteData {
  const ApplicantRoute();

  static const path = '/applicant';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ApplicantPage();
  }
}

@TypedGoRoute<CompanyRoute>(path: CompanyRoute.path)
class CompanyRoute extends GoRouteData {
  const CompanyRoute();

  static const path = '/company';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CompanyPage();
  }
}

@TypedGoRoute<ProfileRoute>(path: ProfileRoute.path)
class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  static const path = '/profile';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfilePage();
  }
}

@TypedGoRoute<VacancyRoute>(path: VacancyRoute.path)
class VacancyRoute extends GoRouteData {
  const VacancyRoute();

  static const path = '/vacancy';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const VacancyPage();
  }
}

class GoNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('did push route $route : $previousRoute');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('did pop route $route : $previousRoute');
  }
}
