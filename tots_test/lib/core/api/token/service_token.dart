import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_test/core/api/token/token.dart';
import 'package:tots_test/core/api/token/token_model.dart';
import 'package:tots_test/core/db_constants.dart';
import 'package:tots_test/core/db_helper.dart';

final tokenServiceProvider = Provider<TokenService>(TokenServiceImpl.fromRef);

abstract class TokenService {
  Future<void> saveToken(Token token);
  Future<TokenModel> loadToken();
  Future<void> resetToken();
}

class TokenServiceImpl implements TokenService {
  TokenServiceImpl({required this.dbHelper});

  factory TokenServiceImpl.fromRef(Ref ref) {
    return TokenServiceImpl(dbHelper: ref.read(dbHelperProvider));
  }

  final DbHelper dbHelper;
  static const tokenE = DbConstants.tokenE;

  @override
  Future<TokenModel> loadToken() async {
    final token = await dbHelper.getData(
        key: tokenE.key, boxName: tokenE.boxName) as String?;
    return TokenModel(token: token);
  }

  @override
  Future<void> saveToken(Token token) async {
    await dbHelper.put(
        key: tokenE.key, data: token.token, boxName: tokenE.boxName);
  }

  @override
  Future<void> resetToken() async {
    await dbHelper.delete(key: tokenE.key, boxName: tokenE.boxName);
  }
}
