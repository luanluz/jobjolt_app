import 'package:jobjolt/feature/company/repository/company.repository.dart';
import 'package:jobjolt/feature/company/state/company_search.state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'company_search.provider.g.dart';

@riverpod
class CompanySearchNotifier extends _$CompanySearchNotifier {
  late final CompanyRepository _repository = ref.read(companyRepositoryProvider);

  @override
  CompanySearchState build() {
    return const CompanySearchState.initial();
  }

  Future<void> searchCompany(String query) async {
    state = const CompanySearchState.loading();
    final response = await _repository.search(query);
    state = response;
  }
}