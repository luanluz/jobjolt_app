import 'package:jobjolt/feature/company/repository/company.repository.dart';
import 'package:jobjolt/feature/company/state/company_show.state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'company_show.provider.g.dart';

@riverpod
class CompanyShowNotifier extends _$CompanyShowNotifier {
  late final CompanyRepository _repository = ref.read(companyRepositoryProvider);

  @override
  CompanyShowState build(int id) {
    getCompany(id);
    return const CompanyShowState.loading();
  }

  Future<void> getCompany(int id) async {
    final response = await _repository.get(id);
    state = response;
  }
}