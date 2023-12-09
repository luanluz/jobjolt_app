// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:jobjolt/feature/auth/model/token.dart';
import 'package:jobjolt/feature/auth/repository/token_repository.dart';
import 'package:jobjolt/feature/auth/state/auth_state.dart';
import 'package:jobjolt/shared/http/api_provider.dart';

abstract class AuthRepositoryProtocol {
  Future<AuthState> login(String email, String password);

  Future<AuthState> signUp(String name, String email, String password);
}

final authRepositoryProvider = Provider(AuthRepository.new);

class AuthRepository implements AuthRepositoryProtocol {
  AuthRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<AuthState> login(String email, String password) async {
    final params = {'email': email, 'password': password};

    final loginResponse = await _api.post('login', jsonEncode(params));

    return loginResponse.when(success: (success) async {
      final tokenRepository = _ref.read(tokenRepositoryProvider);

      final token = Token.fromJson(success as Map<String, dynamic>);

      await tokenRepository.saveToken(token);

      return const AuthState.loggedIn();
    }, error: (error) {
      return AuthState.error(error);
    });
  }

  @override
  Future<AuthState> signUp(String username, String email, String password) async {
    final params = {
      'username': username,
      'email': email,
      'password': password,
    };

    final loginResponse = await _api.post('create-account', jsonEncode(params));

    return loginResponse.when(success: (success) async {
      final tokenRepository = _ref.read(tokenRepositoryProvider);

      final token = Token.fromJson(success as Map<String, dynamic>);

      await tokenRepository.saveToken(token);

      return const AuthState.loggedIn();
    }, error: (error) {
      return AuthState.error(error);
    });
  }
}
