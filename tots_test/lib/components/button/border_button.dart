import 'package:flutter/material.dart';
import 'package:tots_test/utils/palette.dart';

class BorderButton extends StatelessWidget {
  const BorderButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isSelected = false,
    this.color = Colors.white,
    this.maxHeight = 61,
    this.cornerRadius = 30,
    this.enabled = true,
    this.borderColor,
    this.splashColor = const Color(0xFFE4F353),
  });

  final Widget title;
  final bool isSelected;
  final Color color;
  final double maxHeight;
  final double cornerRadius;
  final VoidCallback? onPressed;
  final bool enabled;
  final Color? borderColor;
  final Color? splashColor;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0,
      constraints: BoxConstraints(
        maxWidth: double.infinity,
        maxHeight: maxHeight,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
      fillColor: isSelected
          ? onPressed == null
              ? color.withOpacity(0.3)
              : enabled
                  ? color
                  : color.withOpacity(0.3)
          : null,
      splashColor: splashColor,
      highlightColor: color.withOpacity(0.3),
      onPressed: enabled ? onPressed : null,
      child: AnimatedContainer(
        height: maxHeight,
        decoration: BoxDecoration(
          color: Palette.current.black,
          borderRadius: BorderRadius.circular(cornerRadius),
          border: !isSelected
              ? Border.all(
                  color: borderColor != null ? borderColor! : color,
                )
              : null,
        ),
        alignment: Alignment.center,
        duration: const Duration(
          milliseconds: 250,
        ),
        child: title,
      ),
    );
  }
}
