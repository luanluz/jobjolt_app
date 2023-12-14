// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobjolt/feature/company/provider/company_show.provider.dart';
import 'package:jobjolt/shared/http/app_exception.dart';
import 'package:jobjolt/shared/widget/states/error.widget.dart';
import 'package:jobjolt/shared/widget/loading.widget.dart';

// Project imports:
import 'package:jobjolt/shared/widget/navigation/jobjolt_app_bar.widget.dart';

class CompanyShowPage extends ConsumerWidget {
  final int companyId;

  const CompanyShowPage({
    super.key,
    required this.companyId
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = companyShowNotifierProvider(companyId);
    final state = ref.watch(provider);

    return Scaffold(
      appBar: const JobJoltAppBar(),
      body: Builder(builder: (BuildContext context) {
        return state.when(
          loading: () => const Loading(),
          companyLoaded: (company) =>
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      16.0, 32.0, 16.0, 64.0
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.store_outlined,
                            size: Theme.of(context).textTheme.headlineMedium?.fontSize,
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Text(company.legalName ?? 'Não informado',
                              style: Theme.of(context).textTheme.titleMedium
                            )
                          )
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.domain_outlined),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Text(
                              company.cnpjMask ?? 'Não informado',
                            )
                          )
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.language_outlined,),
                          const SizedBox(width: 16.0),
                          Text(company.website ?? 'Não informado')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          error: (AppException error) =>
              ErrorWidgetState(error.message ?? 'Ocorreu um erro...'),
        );
      }),
    );
  }
}