import 'package:jobjolt/feature/vacancy/repository/vacancy.repository.dart';
import 'package:jobjolt/feature/vacancy/state/vacancy.state.dart';
import 'package:jobjolt/feature/vacancy/state/vacancy_search.state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vacancy_search.provider.g.dart';

@riverpod
class VacancySearchNotifier extends _$VacancySearchNotifier {
  late final VacancyRepository _repository = ref.read(vacancyRepositoryProvider);

  @override
  VacancySearchState build() {
    return const VacancySearchState.initial();
  }

  Future<void> searchVacancy(String query) async {
    state = const VacancySearchState.loading();
    final response = await _repository.search(query);
    state = response;
  }
}