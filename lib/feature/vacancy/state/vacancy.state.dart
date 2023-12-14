// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:jobjolt/feature/vacancy/model/vacancy.model.dart';
import 'package:jobjolt/shared/http/app_exception.dart';

part 'vacancy.state.freezed.dart';

@freezed
class VacancyState with _$VacancyState {
  const factory VacancyState.loading() = _Loading;
  const factory VacancyState.vacancyLoaded(List<Vacancy> vacancies) = _Loaded;
  const factory VacancyState.error(AppException error) = _Error;
}
