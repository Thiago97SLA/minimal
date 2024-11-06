import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_test/core/api/request_handler.dart';

part 'auth_service_impl.dart';

final authServiceProvider = Provider<AuthService>(AuthServiceImpl.fromRead);

abstract class AuthService {
  Future<String> login(String email, String password);
}
