import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_test/components/custom_modals/custom_modals.dart';
import 'package:tots_test/core/state/appstate.dart';

mixin ProviderHelpersMixin {
  BuildContext context(Ref ref) => ref.read(appStateProvider).currentContext;

  CustomModals modals(Ref ref) => ref.read(customModalsProvider);

  Future<void> showLoadingDialog(Ref ref, [BuildContext? context]) =>
      modals(ref).showLoadingDialog(context);

  void removeDialog(Ref ref, [BuildContext? context]) =>
      modals(ref).removeDialog(context);
}
