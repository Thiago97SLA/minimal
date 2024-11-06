import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tots_test/app.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const ProviderScope(child: MyApp()));
}
