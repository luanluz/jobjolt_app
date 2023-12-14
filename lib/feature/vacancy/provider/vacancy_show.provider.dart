import 'package:jobjolt/feature/vacancy/repository/vacancy.repository.dart';
import 'package:jobjolt/feature/vacancy/state/vacancy.state.dart';
import 'package:jobjolt/feature/vacancy/state/vacancy_search.state.dart';
import 'package:jobjolt/feature/vacancy/state/vacancy_show.state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vacancy_show.provider.g.dart';

@riverpod
class VacancyShowNotifier extends _$VacancyShowNotifier {
  late final VacancyRepository _repository = ref.read(vacancyRepositoryProvider);

  @override
  VacancyShowState build(int id) {
    getVacancy(id);
    return const VacancyShowState.loading();
  }

  Future<void> getVacancy(int id) async {
    final response = await _repository.get(id);
    state = response;
  }
}