// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:jobjolt/feature/company/model/company.model.dart';
import 'package:jobjolt/shared/http/app_exception.dart';

part 'company.state.freezed.dart';

@freezed
class CompanyState with _$CompanyState {
  const factory CompanyState.loading() = _Loading;
  const factory CompanyState.companyLoaded(List<Company> companies) = _Loaded;
  const factory CompanyState.error(AppException error) = _Error;
}
