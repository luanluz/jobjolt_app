import 'package:jobjolt/feature/company/repository/company.repository.dart';
import 'package:jobjolt/feature/company/state/company.state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'company.provider.g.dart';

@riverpod
class CompanyNotifier extends _$CompanyNotifier {
  late final CompanyRepository _repository = ref.read(companyRepositoryProvider);

  @override
  CompanyState build() {
    fetchCompany();
    return const CompanyState.loading();
  }

  Future<void> fetchCompany() async {
    state = const CompanyState.loading();
    final response = await _repository.fetch();
    state = response;
  }
}