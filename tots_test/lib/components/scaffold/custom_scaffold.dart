import 'package:flutter/material.dart';
import 'package:tots_test/components/appbar/custom_appbar.dart';
import 'package:tots_test/components/button/border_button.dart';
import 'package:tots_test/constant/imagen.dart';
import 'package:tots_test/utils/palette.dart';

class CustomScaffoldWidget extends StatelessWidget {
  const CustomScaffoldWidget({
    super.key,
    required this.body,
    this.appBar,
    this.bodyWithPadding = true,
    this.textButtonText,
    this.bottonText,
    this.textButtonTextCallback,
    this.textButtonCallback,
    this.isEnableButtonCallback = true,
    this.buttonColor,
    this.sliderConfirmationCallback,
    this.backgroundColor = Colors.white,
    this.isSelected = true,
    this.imgBackground,
  });

  final Widget body;
  final PushedHeader? appBar;
  final bool bodyWithPadding;
  final String? textButtonText;
  final Widget? bottonText;
  final VoidCallback? textButtonTextCallback;
  final VoidCallback? textButtonCallback;
  final bool isEnableButtonCallback;
  final Color? buttonColor;
  final VoidCallback? sliderConfirmationCallback;
  final Color? backgroundColor;
  final bool isSelected;
  final String? imgBackground;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (imgBackground != null)
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              Imagen.backgroundImg,
              fit: BoxFit.cover,
            ),
          ),
        Scaffold(
          backgroundColor:
              imgBackground != null ? Colors.transparent : Colors.white,
          appBar: appBar,
          body: SafeArea(
            child: Container(
              width: double.infinity,
              margin: bodyWithPadding
                  ? const EdgeInsets.only(left: 40, right: 40, bottom: 10)
                  : EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: body),
                  if (textButtonText != null ||
                      bottonText != null ||
                      sliderConfirmationCallback != null) ...[
                    Padding(
                      padding: bodyWithPadding
                          ? EdgeInsets.zero
                          : const EdgeInsets.only(left: 20, right: 20),
                      child: Flex(
                        direction: Axis.vertical,
                        children: [
                          if (bottonText != null &&
                              sliderConfirmationCallback == null)
                            Flexible(
                              flex: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  BorderButton(
                                    isSelected: isSelected,
                                    color: buttonColor ?? Palette.current.black,
                                    enabled: isEnableButtonCallback,
                                    title: bottonText!,
                                    onPressed: textButtonCallback,
                                  ),
                                ],
                              ),
                            ),
                          if (textButtonText != null)
                            const SizedBox(height: 10),
                          if (textButtonText != null)
                            Flexible(
                              flex: 0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: GestureDetector(
                                  onTap: textButtonTextCallback,
                                  child: Text(
                                    textButtonText!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Palette.current.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
