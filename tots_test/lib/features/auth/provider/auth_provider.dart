import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_test/components/custom_modals/custom_modals.dart';
import 'package:tots_test/core/api/token/service_token.dart';
import 'package:tots_test/core/api/token/token.dart';
import 'package:tots_test/core/router/router.dart';
import 'package:tots_test/core/state/appstate.dart';
import 'package:tots_test/features/auth/model/user.dart';
import 'package:tots_test/features/auth/service/auth_service.dart';
import 'package:tots_test/features/home/provider/home_provider.dart';
import 'package:tots_test/features/home/ui/home.dart';
import 'package:tots_test/utils/logger.dart';

part 'auth_state.dart';

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>(AuthNotifier.fromRef);

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({
    required this.ref,
    required this.authService,
    required this.tokenService,
  }) : super(AuthState.initial());

  factory AuthNotifier.fromRef(Ref ref) {
    return AuthNotifier(
      ref: ref,
      authService: ref.read(authServiceProvider),
      tokenService: ref.read(tokenServiceProvider),
    );
  }

  final AuthService authService;
  final TokenService tokenService;

  final Ref ref;

  void resetProvider() => state = AuthState.initial();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      ref.read(customModalsProvider).showLoadingDialog();
      final result = await authService.login(email, password);
      final userpaser = User.fromJson(jsonDecode(result));
      state = state.copyWith(
          user: userpaser, isAuthenticated: IsAuthenticated.authAuthenticated);
      ref.read(customRouterProvider).isAuthenticated = true;
      await tokenService.saveToken(Token(token: userpaser.accessToken));
      ref.read(homeProvider.notifier).getClients();
      ref.read(customModalsProvider).removeDialog();
      ref.read(appStateProvider).router.pushNamed(HomePage.route);
    } catch (e) {
      CustomLogger.log(e.toString());
      ref.read(customModalsProvider).removeDialog();
      ref.read(customModalsProvider).showErrorDialog();
    }
  }
}
