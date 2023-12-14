// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:jobjolt/feature/company/model/company.model.dart';
import 'package:jobjolt/shared/http/app_exception.dart';

part 'company_show.state.freezed.dart';

@freezed
class CompanyShowState with _$CompanyShowState {
  const factory CompanyShowState.loading() = _Loading;
  const factory CompanyShowState.companyLoaded(Company company) = _Loaded;
  const factory CompanyShowState.error(AppException error) = _Error;
}
