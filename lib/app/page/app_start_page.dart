// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:jobjolt/app/provider/app_start_provider.dart';
import 'package:jobjolt/feature/auth/page/sign_in.page.dart';
import 'package:jobjolt/feature/vacancy/page/vacancy.page.dart';
import 'package:jobjolt/shared/widget/connection_unavailable_widget.dart';
import 'package:jobjolt/shared/widget/loading_page.widget.dart';

class AppStartPage extends ConsumerWidget {
  const AppStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStartNotifierProvider);

    return state.when(
        data: (data) {
          return data.maybeWhen(
            initial: () => const LoadingPage(),
            authenticated: () => const VacancyPage(),
            unauthenticated: SignInPage.new,
            internetUnAvailable: () => const ConnectionUnavailableWidget(),
            orElse: () => const LoadingPage(),
          );
        },
        error: (e, st) => const LoadingPage(),
        loading: () => const LoadingPage());
  }
}
