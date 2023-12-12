// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:jobjolt/shared/widget/navigation/bar/jobjolt_bottom_navigation_bar.widget.dart';
import 'package:jobjolt/shared/widget/navigation/jobjolt_app_bar.widget.dart';

class VacancyPage extends ConsumerStatefulWidget {
  const VacancyPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<VacancyPage> createState() => _VacancyPageState();
}

class _VacancyPageState extends ConsumerState<VacancyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const JobJoltAppBar(),
      bottomNavigationBar: const JobJoltBottomNavigationBar(),
      body: Center(child: Text('Vacancy')),
    );
  }
}