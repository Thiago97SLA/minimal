part of 'home_provider.dart';

class HomeState extends Equatable {
  const HomeState({
    this.clients,
  });

  factory HomeState.initial() {
    return const HomeState(
      clients: [],
    );
  }

  final List<ClientModel>? clients;

  HomeState copyWith({
    List<ClientModel>? clients,
  }) {
    return HomeState(
      clients: clients ?? clients,
    );
  }

  @override
  List<Object?> get props => [clients];
}
