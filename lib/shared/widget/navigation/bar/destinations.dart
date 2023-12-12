// Flutter imports:
import 'package:flutter/material.dart';
import 'package:jobjolt/shared/route/app_router.dart';

// Project imports:
import 'package:jobjolt/shared/widget/navigation/bar/bar_destination.dart';

final barDestinations = <BarDestination>[
  BarDestination(
    route: VacancyRoute.path,
    label: 'Vagas',
    icon: const Icon(Icons.business_center_outlined),
    selectedIcon: const Icon(Icons.business_center),
  ),
  BarDestination(
    route: CompanyRoute.path,
    label: 'Empresas',
    icon: const Icon(Icons.store_outlined),
    selectedIcon: const Icon(Icons.store),
  ),
  BarDestination(
    route: ApplicantRoute.path,
    label: 'Profissionais',
    icon: const Icon(Icons.group_outlined),
    selectedIcon: const Icon(Icons.group),
  ),
  BarDestination(
    route: ProfileRoute.path,
    label: 'Perfil',
    icon: const Icon(Icons.person_outline),
    selectedIcon: const Icon(Icons.person),
  ),
];
