part of 'home_service.dart';

class HomeServiceImpl implements HomeService {
  HomeServiceImpl({
    required this.client,
  });

  factory HomeServiceImpl.fromRead(Ref ref) {
    return HomeServiceImpl(
      client: ref.read(requestHandlerProvider),
    );
  }
  final RequestHandler client;

  @override
  Future<List<ClientModel>> getClients() async {
    const path = '/clients';
    final res = await client.performGet(path);
    final parseCient = jsonDecode(res.rawResponse.toString());
    final getData = (parseCient['data'] as List<dynamic>)
        .map((e) => ClientModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return getData;
  }

  @override
  Future<void> createClient(ClientModel user) async {
    const path = '/clients';
    final body = <String, dynamic>{
      "firstname": user.firstname,
      "lastname": user.lastname,
      "email": user.email,
      "address": "Buenos Aires, Argentina",
      "photo": "",
      "caption": ""
    };
    await client.performPost(path, body);
    return;
  }

  @override
  Future<void> updateClient(ClientModel user) async {
    const path = '/clients';
    final body = <String, dynamic>{
      "firstname": user.firstname,
      "lastname": user.lastname,
      "email": user.email,
      "address": user.address,
      "photo": user.photo,
      "caption": ''
    };
    await client.performPost(path, body);
    return;
  }
}
