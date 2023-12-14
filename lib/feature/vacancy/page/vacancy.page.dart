// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobjolt/feature/vacancy/provider/vacancy.provider.dart';
import 'package:jobjolt/feature/vacancy/widget/vacancy_card.widget.dart';
import 'package:jobjolt/shared/http/app_exception.dart';
import 'package:jobjolt/shared/route/app_router.dart';
import 'package:jobjolt/shared/widget/button/jobjolt_filled_button_icon.widget.dart';
import 'package:jobjolt/shared/widget/states/empty_list.widget.dart';
import 'package:jobjolt/shared/widget/states/error.widget.dart';
import 'package:jobjolt/shared/widget/loading.widget.dart';

// Project imports:
import 'package:jobjolt/shared/widget/navigation/bar/jobjolt_bottom_navigation_bar.widget.dart';
import 'package:jobjolt/shared/widget/navigation/jobjolt_app_bar.widget.dart';

class VacancyPage extends ConsumerWidget {
  const VacancyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(vacancyNotifierProvider);
    final notifier = ref.read(vacancyNotifierProvider.notifier);

    return Scaffold(
      appBar: const JobJoltAppBar(),
      bottomNavigationBar: const JobJoltBottomNavigationBar(),
      body: RefreshIndicator(
        onRefresh: () async => notifier.fetchVacancy(),
        child: Builder(builder: (BuildContext context) {
          return state.when(
            loading: () => const Loading(),
            vacancyLoaded: (vacancies) =>
              Builder(
                builder: (context) {
                  if (vacancies.isEmpty) {
                    return EmptyListState('Ainda não há informações para listar...');
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                            child: JobJoltFilledButtonTonalIcon(
                              text: 'Procurar por...',
                              icon: const Icon(Icons.search_outlined),
                              onPressed: () => ref.read(routerProvider).push(VacancySearchRoute.path),
                            )
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 32.0)),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: vacancies.length,
                              (BuildContext context, int index) =>
                                  VacancyCard(vacancy: vacancies[index])
                          )
                        )
                      ],
                    ),
                  );
                }
              ),
            error: (AppException error) =>
                ErrorWidgetState(error.message ?? 'Ocorreu um erro...'),
          );
        }),
      ),
    );
  }
}
