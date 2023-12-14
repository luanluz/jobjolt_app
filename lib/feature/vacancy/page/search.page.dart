// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobjolt/feature/vacancy/provider/vacancy.provider.dart';
import 'package:jobjolt/feature/vacancy/provider/vacancy_search.provider.dart';
import 'package:jobjolt/feature/vacancy/widget/vacancy_card.widget.dart';
import 'package:jobjolt/shared/http/app_exception.dart';
import 'package:jobjolt/shared/widget/form/jobjolt_text_form_field.widget.dart';
import 'package:jobjolt/shared/widget/states/empty_list.widget.dart';
import 'package:jobjolt/shared/widget/states/error.widget.dart';
import 'package:jobjolt/shared/widget/loading.widget.dart';

// Project imports:
import 'package:jobjolt/shared/widget/navigation/jobjolt_app_bar.widget.dart';
import 'package:zod_validation/zod_validation.dart';

class VacancySearchPage extends ConsumerWidget {
  const VacancySearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(vacancySearchNotifierProvider);
    final notifier = ref.read(vacancySearchNotifierProvider.notifier);
    final _searchController = TextEditingController();

    return Scaffold(
      appBar: const JobJoltAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: JobJoltTextFormField(
                autofocus: true,
                controller: _searchController,
                suffixIcon: IconButton(
                  onPressed: () async {
                    if (_searchController.value.text.isNotEmpty) {
                      await notifier.searchVacancy(_searchController.text);
                    }
                  },
                  icon: const Icon(Icons.search_outlined)
                ),
                labelText: 'Procurar por...',
                validator: Zod().required().build,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32.0)),
            state.when(
              initial: () => const SliverToBoxAdapter(),
              loading: () => const SliverToBoxAdapter(child: const Loading()),
              vacancyLoaded: (vacancies) =>
                Builder(
                  builder: (context) {
                    if (vacancies.isEmpty) {
                      return const SliverToBoxAdapter(
                          child: EmptyListState('Ainda não há informações para listar...')
                      );
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: vacancies.length,
                          (BuildContext context, int index) =>
                            VacancyCard(vacancy: vacancies[index])
                      )
                    );
                  }
                ),
              error: (AppException error) =>
                  SliverToBoxAdapter(child:
                    ErrorWidgetState(error.message ?? 'Ocorreu um erro...')
                  ),
            ),
          ],
        ),
      ),
    );
  }
}