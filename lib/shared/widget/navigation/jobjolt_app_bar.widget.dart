// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:jobjolt/feature/auth/provider/auth_provider.dart';
import 'package:jobjolt/shared/widget/jobjolt_logo.widget.dart';

class JobJoltAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const JobJoltAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: const JobJoltLogo(height: 30.0),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      actions: [
        TextButton.icon(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.only(left: 12.0, right: 12.0)
            )
          ),
          icon: const Icon(Icons.logout_outlined),
          label: Text('Sair'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: const Text('Sair do App'),
                  content: const Text('Deseja encerrar sua sessão no app?'),
                  actions: [
                    TextButton(
                      onPressed: Navigator.of(context).pop,
                      child: const Text('Não')
                    ),
                    FilledButton.tonal(
                      onPressed: () {
                        ref.read(authNotifierProvider.notifier).logout();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Sim')
                    )
                  ],
                );
              });
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
