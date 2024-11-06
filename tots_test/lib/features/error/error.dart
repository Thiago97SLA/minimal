import 'package:flutter/material.dart';
import 'package:tots_test/components/button/border_button.dart';
import 'package:tots_test/components/scaffold/custom_scaffold.dart';

class ErrorScreenArgs {
  const ErrorScreenArgs({
    required this.title,
    this.message = 'Ups ha ocurrido un error',
    this.showButtons = true,
    this.onError,
    this.onErrorText,
  });

  final String message;
  final String? onErrorText;
  final String title;
  final bool showButtons;
  final VoidCallback? onError;

  @override
  String toString() {
    return 'ErrorScreenArgs(message: $message, title: $title, showButtons: $showButtons, onError: $onError)';
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    this.message = 'Ups ha ocurrido un error',
    this.title,
    this.showButtons = true,
    this.onError,
    this.onErrorText,
  });

  static const route = '/Error';
  final String? message;
  final String? title;
  final String? onErrorText;
  final bool showButtons;
  final VoidCallback? onError;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (title != null)
            Text(
              title!,
              textAlign: TextAlign.center,
            ),
          Text(
            message ?? 'Ups ha ocurrido un error',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          if (showButtons & Navigator.of(context).canPop())
            BorderButton(
              onPressed: () => Navigator.of(context).pop(),
              title: const Text(
                'Salir',
              ),
            ),
          if (onError != null)
            BorderButton(
              onPressed: onError,
              title: Text(onErrorText ?? 'Intenta de nuevo'),
            )
        ],
      ),
    );
  }
}
