// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobjolt/feature/vacancy/model/vacancy.model.dart';
import 'package:jobjolt/feature/vacancy/state/vacancy.state.dart';
import 'package:jobjolt/feature/vacancy/state/vacancy_search.state.dart';
import 'package:jobjolt/feature/vacancy/state/vacancy_show.state.dart';

// Project imports:
import 'package:jobjolt/shared/http/api_provider.dart';
import 'package:jobjolt/shared/http/api_response.dart';
import 'package:jobjolt/shared/http/app_exception.dart';

final vacancyRepositoryProvider = Provider(VacancyRepository.new);

class VacancyRepository {
  VacancyRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  Future<VacancyState> fetch() async {
    final response = await _api.get('vacancy');

    response.when(
        success: (success) {},
        error: (error) {
          return VacancyState.error(error);
        });

    if (response is APISuccess) {
      final value = response.value;
      try {
        final vacancies = List.from(value ?? [])
            .map((e) => Vacancy.fromJson(e))
            .toList();

        return VacancyState.vacancyLoaded(vacancies);
      } catch (e) {
        return VacancyState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return VacancyState.error(response.exception);
    } else {
      return const VacancyState.loading();
    }
  }

  Future<VacancySearchState> search(String query) async {
    final response = await _api.get('vacancy/search?q=$query');

    response.when(
        success: (success) {},
        error: (error) {
          return VacancySearchState.error(error);
        });

    if (response is APISuccess) {
      final value = response.value;
      try {
        final vacancies = List.from(value ?? [])
            .map((e) => Vacancy.fromJson(e))
            .toList();

        return VacancySearchState.vacancyLoaded(vacancies);
      } catch (e) {
        return VacancySearchState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return VacancySearchState.error(response.exception);
    } else {
      return const VacancySearchState.loading();
    }
  }

  Future<VacancyShowState> get(int id) async {
    final response = await _api.get('vacancy/$id');

    response.when(
        success: (success) {},
        error: (error) {
          return VacancyShowState.error(error);
        });

    if (response is APISuccess) {
      final value = response.value;
      try {
        final vacancy = Vacancy.fromJson(value);

        return VacancyShowState.vacancyLoaded(vacancy);
      } catch (e) {
        return VacancyShowState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return VacancyShowState.error(response.exception);
    } else {
      return const VacancyShowState.loading();
    }
  }
}
