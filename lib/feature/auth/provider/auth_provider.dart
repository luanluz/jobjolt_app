// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:jobjolt/feature/auth/repository/auth_repository.dart';
import 'package:jobjolt/feature/auth/repository/token_repository.dart';
import 'package:jobjolt/feature/auth/state/auth_state.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    return const AuthState.initial();
  }

  late final AuthRepository _loginRepository = ref.read(authRepositoryProvider);

  Future<void> login(String email, String password) async {
    state = await _loginRepository.login(email, password);
  }

  Future<void> signUp(String username, String email, String password) async {
    state = await _loginRepository.signUp(username, email, password);
  }

  late final TokenRepository _tokenRepository =
      ref.read(tokenRepositoryProvider);

  Future<void> logout() async {
    await _tokenRepository.remove();
    state = const AuthState.loggedOut();
  }
}
