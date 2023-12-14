// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:jobjolt/app/provider/app_start_provider.dart';
import 'package:jobjolt/feature/auth/page/sign_in.page.dart';
import 'package:jobjolt/feature/home/page/home_page.dart';
import 'package:jobjolt/feature/vacancy/page/vacancy.page.dart';
import 'package:jobjolt/shared/widget/connection_unavailable_widget.dart';
import 'package:jobjolt/shared/widget/loading_widget.dart';

class AppStartPage extends ConsumerWidget {
  const AppStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStartNotifierProvider);

    return state.when(
        data: (data) {
          return data.maybeWhen(
            initial: () => const LoadingWidget(),
            authenticated: () => const VacancyPage(),
            unauthenticated: SignInPage.new,
            internetUnAvailable: () => const ConnectionUnavailableWidget(),
            orElse: () => const LoadingWidget(),
          );
        },
        error: (e, st) => const LoadingWidget(),
        loading: () => const LoadingWidget());
  }
}
