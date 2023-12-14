// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobjolt/feature/vacancy/provider/vacancy.provider.dart';
import 'package:jobjolt/feature/vacancy/provider/vacancy_show.provider.dart';
import 'package:jobjolt/shared/http/app_exception.dart';
import 'package:jobjolt/shared/widget/states/error.widget.dart';
import 'package:jobjolt/shared/widget/loading.widget.dart';

// Project imports:
import 'package:jobjolt/shared/widget/navigation/jobjolt_app_bar.widget.dart';

class VacancyShowPage extends ConsumerWidget {
  final int vacancyId;

  const VacancyShowPage({
    super.key,
    required this.vacancyId
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = vacancyShowNotifierProvider(vacancyId);
    final state = ref.watch(provider);

    return Scaffold(
      appBar: const JobJoltAppBar(),
      body: Builder(builder: (BuildContext context) {
        return state.when(
          loading: () => const Loading(),
          vacancyLoaded: (vacancy) =>
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      16.0, 32.0, 16.0, 64.0
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.badge_outlined,
                            size: Theme.of(context).textTheme.headlineMedium?.fontSize,
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Text(vacancy.position ?? 'Não informado',
                              style: Theme.of(context).textTheme.titleMedium
                            )
                          )
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.checklist_outlined),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Text(
                              vacancy.positionSpecification ?? 'Não informado',
                            )
                          )
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.attach_money,),
                          const SizedBox(width: 16.0),
                          Text(vacancy.salaryFormatted.toString())
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.text_snippet_outlined),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Text(vacancy.observation ?? 'Não informado'),
                          )
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.watch_later_outlined),
                          const SizedBox(width: 16.0),
                          Text(vacancy.workShift?.desc ?? 'Não informado')
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.gavel_outlined),
                          const SizedBox(width: 16.0),
                          Text(vacancy.employmentType?.desc ?? 'Não informado')
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.flight),
                          const SizedBox(width: 16.0),
                          Text(vacancy.isRemote ?? false ? 'Sim' : 'Não')
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on_outlined),
                          const SizedBox(width: 16.0),
                          Text("${vacancy.city} - ${vacancy.state}")
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          error: (AppException error) =>
              ErrorWidgetState(error.message ?? 'Ocorreu um erro...'),
        );
      }),
    );
  }
}