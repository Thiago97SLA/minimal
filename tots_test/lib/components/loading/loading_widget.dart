import 'package:flutter/material.dart';
import 'package:tots_test/utils/palette.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Palette.current.appleGreenLight,
        ),
      ),
    );
  }
}
