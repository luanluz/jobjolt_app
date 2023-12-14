// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:jobjolt/feature/company/model/company.model.dart';
import 'package:jobjolt/shared/http/app_exception.dart';

part 'company_search.state.freezed.dart';

@freezed
class CompanySearchState with _$CompanySearchState {
  const factory CompanySearchState.initial() = _Initial;
  const factory CompanySearchState.loading() = _Loading;
  const factory CompanySearchState.companyLoaded(List<Company> companies) = _Loaded;
  const factory CompanySearchState.error(AppException error) = _Error;
}
