import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_test/core/router/router.dart';
import 'package:tots_test/core/state/appstate.dart';
import 'package:tots_test/features/auth/ui/login.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final appState = ref.read(appStateProvider);

    return MaterialApp(
      scrollBehavior: const ScrollBehavior(),
      navigatorKey: appState.context,
      scaffoldMessengerKey: appState.scaffoldMessengerKey,
      initialRoute: LoginPage.route,
      onGenerateRoute: ref.read(customRouterProvider).onGenerateRoute,
      title: 'Tots App',
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
