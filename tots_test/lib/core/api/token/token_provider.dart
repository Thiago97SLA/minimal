import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_test/core/api/token/service_token.dart';

final tokenUtilsProvider = Provider<TokenUtils>((ref) {
  return TokenUtils.fromRef(ref);
});

class TokenUtils {
  TokenUtils({required this.tokenService});

  factory TokenUtils.fromRef(Ref ref) {
    return TokenUtils(tokenService: ref.read(tokenServiceProvider));
  }

  final TokenService tokenService;

  Future<String?> getToken() async {
    final token = await tokenService.loadToken();
    return token.bearerToken.toString();
  }
}
