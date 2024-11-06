import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_test/core/api/request_handler.dart';
import 'package:tots_test/features/home/model/clients_model.dart';

part 'home_service_impl.dart';

final homeServiceProvider = Provider<HomeService>(HomeServiceImpl.fromRead);

abstract class HomeService {
  Future<List<ClientModel>> getClients();

  Future<void> createClient(ClientModel user);

  Future<void> updateClient(ClientModel user);
}
