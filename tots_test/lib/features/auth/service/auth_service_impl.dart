part of 'auth_service.dart';

class AuthServiceImpl implements AuthService {
  AuthServiceImpl({
    required this.client,
  });

  factory AuthServiceImpl.fromRead(Ref ref) {
    return AuthServiceImpl(
      client: ref.read(requestHandlerProvider),
    );
  }
  final RequestHandler client;

  @override
  Future<String> login(String email, String password) async {
    const path = '/oauth/token';
    final body = <String, dynamic>{"email": email, "password": password};
    final res = await client.performPost(
      path,
      body,
      withJwtToken: false,
    );
    return res.rawResponse.toString();
  }
}
