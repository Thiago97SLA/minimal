// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tots_test/utils/palette.dart';

class PushedHeader extends StatefulWidget implements PreferredSizeWidget {
  static const _defaultActions = <Widget>[];
  final List<Widget> actions;
  final bool showBackButton;
  Widget? customWidget;
  Widget title;
  double height;
  bool isDarkBackground;
  Color backgroundColor;
  Widget? suffixIconButton;
  bool goHome;
  VoidCallback? customcallback;

  PushedHeader({
    super.key,
    this.actions = _defaultActions,
    this.showBackButton = true,
    this.customWidget,
    this.title = const Text(""),
    this.height = 55,
    this.isDarkBackground = false,
    this.backgroundColor = Colors.white,
    this.suffixIconButton,
    this.goHome = false,
    this.customcallback,
  });

  @override
  State<PushedHeader> createState() => _PushedHeaderState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _PushedHeaderState extends State<PushedHeader>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(22),
      child: AppBar(
        systemOverlayStyle: widget.isDarkBackground
            ? SystemUiOverlayStyle(
                statusBarColor: Palette.current.black,
                statusBarIconBrightness:
                    Brightness.light, // For Android (dark icons)
                statusBarBrightness: Brightness.dark, // For iOS (dark icons)
              )
            : null,
        backgroundColor: widget.backgroundColor,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: NavigationToolbar(
            middleSpacing: 0,
            centerMiddle: false,
            middle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12, top: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.showBackButton
                          ? IconButton(
                              icon: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    border: Border.all(
                                      color: widget.isDarkBackground
                                          ? Colors.white
                                          : Palette.current.black,
                                    ),
                                  ),
                                  child: const Icon(Icons.arrow_back)),
                              onPressed:
                                  widget.customcallback != null ? () {} : null,
                            )
                          : const SizedBox(
                              width: 16,
                            ),
                      widget.title,
                      widget.suffixIconButton != null
                          ? Expanded(
                              child: Row(
                                children: [
                                  const Spacer(),
                                  widget.suffixIconButton!,
                                ],
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
                SizedBox(
                  height: widget.customWidget != null ? 20 : 0,
                ),
                widget.customWidget ?? Container(),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widget.actions,
            ),
          ),
        ),
      ),
    );
  }
}
