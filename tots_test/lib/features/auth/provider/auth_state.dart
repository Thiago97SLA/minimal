part of 'auth_provider.dart';

enum IsAuthenticated { authNotAuthenticated, authAuthenticated }

class AuthState extends Equatable {
  const AuthState({
    required this.isAuthenticated,
    this.user,
  });

  factory AuthState.initial() {
    return const AuthState(
      isAuthenticated: IsAuthenticated.authNotAuthenticated,
    );
  }

  final IsAuthenticated? isAuthenticated;
  final User? user;

  AuthState copyWith({
    IsAuthenticated? isAuthenticated,
    User? user,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? user,
    );
  }

  @override
  List<Object?> get props => [isAuthenticated, user];
}
