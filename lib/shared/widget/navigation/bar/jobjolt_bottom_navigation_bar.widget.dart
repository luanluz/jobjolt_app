import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobjolt/shared/route/app_router.dart';
import 'package:jobjolt/shared/widget/navigation/bar/destinations.dart';

final bottomNavigationProvider = StateProvider<int>((ref) => 0);

class JobJoltBottomNavigationBar extends ConsumerWidget {
  const JobJoltBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageIndex = ref.watch(bottomNavigationProvider);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: NavigationBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        onDestinationSelected: (int index) {
          ref.read(bottomNavigationProvider.notifier).state = index;
          ref.read(routerProvider).go(barDestinations[index].route);
        },
        selectedIndex: currentPageIndex,
        destinations: barDestinations.map((destination) =>
            NavigationDestination(
              label: destination.label,
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
            ),
        ).toList(),
      ),
    );
  }
}
