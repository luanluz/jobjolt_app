// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:jobjolt/feature/vacancy/model/vacancy.model.dart';
import 'package:jobjolt/shared/http/app_exception.dart';

part 'vacancy_show.state.freezed.dart';

@freezed
class VacancyShowState with _$VacancyShowState {
  const factory VacancyShowState.loading() = _Loading;
  const factory VacancyShowState.vacancyLoaded(Vacancy vacancy) = _Loaded;
  const factory VacancyShowState.error(AppException error) = _Error;
}
