import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobjolt/feature/vacancy/model/vacancy.model.dart';
import 'package:jobjolt/shared/route/app_router.dart';

class VacancyCard extends ConsumerWidget {
  final Vacancy vacancy;

  const VacancyCard({
    super.key,
    required this.vacancy
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
            onTap: () => _showVacancy(vacancy.id, ref),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(vacancy.position ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: false
                  ),
                  subtitle: Text(vacancy.observation ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    softWrap: false
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 16.0,
                      top: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          const Icon(Icons.attach_money),
                          const SizedBox(width: 4),
                          Text(vacancy.salaryFormatted.toString())
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined),
                          const SizedBox(width: 4),
                          Text(vacancy.isRemote ?? false ? 'Remoto' : "${vacancy.city} - ${vacancy.state}")
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.badge_outlined),
                          const SizedBox(width: 4),
                          Text(vacancy.employmentType?.desc ?? 'Não especificado')
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8.0)
      ],
    );
  }

  _showVacancy(int? id, WidgetRef ref) =>
      ref.read(routerProvider).push(VacancyShowRoute.path, extra: id);
}
