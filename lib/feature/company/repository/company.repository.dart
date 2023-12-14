// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobjolt/feature/company/model/company.model.dart';
import 'package:jobjolt/feature/company/state/company.state.dart';
import 'package:jobjolt/feature/company/state/company_search.state.dart';
import 'package:jobjolt/feature/company/state/company_show.state.dart';

// Project imports:
import 'package:jobjolt/shared/http/api_provider.dart';
import 'package:jobjolt/shared/http/api_response.dart';
import 'package:jobjolt/shared/http/app_exception.dart';

final companyRepositoryProvider = Provider(CompanyRepository.new);

class CompanyRepository {
  CompanyRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  Future<CompanyState> fetch() async {
    final response = await _api.get('company');

    response.when(
        success: (success) {},
        error: (error) {
          return CompanyState.error(error);
        });

    if (response is APISuccess) {
      final value = response.value;
      try {
        final vacancies = List.from(value ?? [])
            .map((e) => Company.fromJson(e))
            .toList();

        return CompanyState.companyLoaded(vacancies);
      } catch (e) {
        return CompanyState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return CompanyState.error(response.exception);
    } else {
      return const CompanyState.loading();
    }
  }

  Future<CompanySearchState> search(String query) async {
    final response = await _api.get('company/search?q=$query');

    response.when(
        success: (success) {},
        error: (error) {
          return CompanySearchState.error(error);
        });

    if (response is APISuccess) {
      final value = response.value;
      try {
        final vacancies = List.from(value ?? [])
            .map((e) => Company.fromJson(e))
            .toList();

        return CompanySearchState.companyLoaded(vacancies);
      } catch (e) {
        return CompanySearchState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return CompanySearchState.error(response.exception);
    } else {
      return const CompanySearchState.loading();
    }
  }

  Future<CompanyShowState> get(int id) async {
    final response = await _api.get('company/$id');

    response.when(
        success: (success) {},
        error: (error) {
          return CompanyShowState.error(error);
        });

    if (response is APISuccess) {
      final value = response.value;
      try {
        final company = Company.fromJson(value);

        return CompanyShowState.companyLoaded(company);
      } catch (e) {
        return CompanyShowState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return CompanyShowState.error(response.exception);
    } else {
      return const CompanyShowState.loading();
    }
  }
}
