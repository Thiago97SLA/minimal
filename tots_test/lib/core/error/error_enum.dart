import 'package:flutter/material.dart';

enum ErrorType {
  errorAuth,
  errorNotAuth;

  void onAction(BuildContext context) {
    switch (this) {
      case ErrorType.errorAuth:
        break;
      case ErrorType.errorNotAuth:
        // Navigator.of(context).pushNamed(
        // );
    }
  }

  String get actionMessage {
    switch (this) {
      case ErrorType.errorAuth:
        return 'Ocurrió un error';
      case ErrorType.errorNotAuth:
        return 'Ocurrió un error';
    }
  }
}
