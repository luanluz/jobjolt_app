import 'package:jobjolt/feature/vacancy/repository/vacancy.repository.dart';
import 'package:jobjolt/feature/vacancy/state/vacancy.state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vacancy.provider.g.dart';

@riverpod
class VacancyNotifier extends _$VacancyNotifier {
  late final VacancyRepository _repository = ref.read(vacancyRepositoryProvider);

  @override
  VacancyState build() {
    fetchVacancy();
    return const VacancyState.loading();
  }

  Future<void> fetchVacancy() async {
    state = const VacancyState.loading();
    final response = await _repository.fetch();
    state = response;
  }
}