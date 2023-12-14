// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobjolt/feature/company/provider/company.provider.dart';
import 'package:jobjolt/feature/company/widget/company_card.widget.dart';
import 'package:jobjolt/shared/http/app_exception.dart';
import 'package:jobjolt/shared/route/app_router.dart';
import 'package:jobjolt/shared/widget/button/jobjolt_filled_button_icon.widget.dart';
import 'package:jobjolt/shared/widget/states/empty_list.widget.dart';
import 'package:jobjolt/shared/widget/states/error.widget.dart';
import 'package:jobjolt/shared/widget/loading.widget.dart';

// Project imports:
import 'package:jobjolt/shared/widget/navigation/bar/jobjolt_bottom_navigation_bar.widget.dart';
import 'package:jobjolt/shared/widget/navigation/jobjolt_app_bar.widget.dart';

class CompanyPage extends ConsumerWidget {
  const CompanyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(companyNotifierProvider);
    final notifier = ref.read(companyNotifierProvider.notifier);

    return Scaffold(
      appBar: const JobJoltAppBar(),
      bottomNavigationBar: const JobJoltBottomNavigationBar(),
      body: RefreshIndicator(
        onRefresh: () async => notifier.fetchCompany(),
        child: Builder(builder: (BuildContext context) {
          return state.when(
            loading: () => const Loading(),
            companyLoaded: (companies) =>
              Builder(
                builder: (context) {
                  if (companies.isEmpty) {
                    return EmptyListState('Ainda não há informações para listar...');
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                            child: JobJoltFilledButtonTonalIcon(
                              text: 'Procurar por...',
                              icon: const Icon(Icons.search_outlined),
                              onPressed: () => ref.read(routerProvider).push(CompanySearchRoute.path),
                            )
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 32.0)),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: companies.length,
                              (BuildContext context, int index) =>
                                  CompanyCard(company: companies[index])
                          )
                        )
                      ],
                    ),
                  );
                }
              ),
            error: (AppException error) =>
                ErrorWidgetState(error.message ?? 'Ocorreu um erro...'),
          );
        }),
      ),
    );
  }
}
