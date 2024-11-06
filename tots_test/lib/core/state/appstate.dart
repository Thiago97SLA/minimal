import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appStateProvider = Provider((ref) => AppStateImpl(ref: ref));

abstract class AppState {
  AppState(this.ref);

  BuildContext get currentContext;
  NavigatorState get router;
  ScaffoldMessengerState get scaffoldMessenger;
  final Ref ref;
  final context = GlobalKey<NavigatorState>();
}

class AppStateImpl implements AppState {
  AppStateImpl({required this.ref});

  @override
  final context = GlobalKey<NavigatorState>();
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  final Ref ref;

  @override
  BuildContext get currentContext => context.currentState!.overlay!.context;
  @override
  NavigatorState get router => context.currentState!;
  @override
  ScaffoldMessengerState get scaffoldMessenger =>
      scaffoldMessengerKey.currentState!;
}
