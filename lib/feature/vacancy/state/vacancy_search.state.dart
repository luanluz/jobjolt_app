// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:jobjolt/feature/vacancy/model/vacancy.model.dart';
import 'package:jobjolt/shared/http/app_exception.dart';

part 'vacancy_search.state.freezed.dart';

@freezed
class VacancySearchState with _$VacancySearchState {
  const factory VacancySearchState.initial() = _Initial;
  const factory VacancySearchState.loading() = _Loading;
  const factory VacancySearchState.vacancyLoaded(List<Vacancy> vacancies) = _Loaded;
  const factory VacancySearchState.error(AppException error) = _Error;
}
