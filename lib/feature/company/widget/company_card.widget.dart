import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobjolt/feature/company/model/company.model.dart';
import 'package:jobjolt/shared/route/app_router.dart';

class CompanyCard extends ConsumerWidget {
  final Company company;

  const CompanyCard({
    super.key,
    required this.company
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: InkWell(
            onTap: () => _showCompany(company.id, ref),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                radius: 20, // Raio do avatar
                child: Text(
                  company.initials,
                  style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
              title: Text(company.legalName ?? 'Não informado'),
              subtitle: Text(company.cnpjMask ?? 'Não informado'),
            ),
          ),
        ),
        const SizedBox(height: 8.0)
      ],
    );
  }

  _showCompany(int? id, WidgetRef ref) =>
      ref.read(routerProvider).push(CompanyShowRoute.path, extra: id);
}
