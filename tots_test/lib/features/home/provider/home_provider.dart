import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_test/components/custom_modals/custom_modals.dart';
import 'package:tots_test/features/home/model/clients_model.dart';
import 'package:tots_test/features/home/service/home_service.dart';
import 'package:tots_test/utils/logger.dart';

part 'home_state.dart';

final homeProvider =
    StateNotifierProvider<HomeNotifier, HomeState>(HomeNotifier.fromRef);

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier({required this.ref, required this.homeService})
      : super(HomeState.initial());

  factory HomeNotifier.fromRef(Ref ref) {
    return HomeNotifier(
      ref: ref,
      homeService: ref.read(homeServiceProvider),
    );
  }

  final HomeService homeService;
  final Ref ref;

  void resetProvider() => state = HomeState.initial();

  Future<void> getClients() async {
    try {
      final result = await homeService.getClients();
      state = state.copyWith(clients: result);
    } catch (e) {
      ref.read(customModalsProvider).showErrorDialog();
      CustomLogger.log(e.toString());
    }
  }

  Future<void> createClients(ClientModel user) async {
    try {
      ref.read(customModalsProvider).showLoadingDialog();
      await homeService.createClient(user);
      ref.read(customModalsProvider).removeDialog();
      ref.read(customModalsProvider).removeDialog();
      ref.read(customModalsProvider).showSuccesDialog();

      getClients();
    } catch (e) {
      ref.read(customModalsProvider).removeDialog();
      ref.read(customModalsProvider).showErrorDialog();
      CustomLogger.log(e.toString());
    }
  }

  Future<void> updateClients(ClientModel user) async {
    try {
      ref.read(customModalsProvider).showLoadingDialog();
      await homeService.updateClient(user);
      ref.read(customModalsProvider).removeDialog();
      ref.read(customModalsProvider).removeDialog();
      ref.read(customModalsProvider).showSuccesDialog();

      getClients();
    } catch (e) {
      ref.read(customModalsProvider).removeDialog();
      ref.read(customModalsProvider).showErrorDialog();
      CustomLogger.log(e.toString());
    }
  }
}
